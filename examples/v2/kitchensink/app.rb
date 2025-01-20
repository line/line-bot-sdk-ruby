require 'json'
require 'sinatra'
require 'line/bot'

set :environment, :production
set :app_base_url, ENV['APP_BASE_URL']

THUMBNAIL_URL = 'https://via.placeholder.com/1024x1024'
HORIZONTAL_THUMBNAIL_URL = 'https://via.placeholder.com/1024x768'
QUICK_REPLY_ICON_URL = 'https://via.placeholder.com/64x64'

def client
  @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
    http_options: {
      open_timeout: 5,
      read_timeout: 5
    }
  )
end

def blob_client
  @blob_client ||= Line::Bot::V2::MessagingApi::ApiBlobClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
    http_options: {
      open_timeout: 5,
      read_timeout: 5
    }
  )
end

def insight_client
  @insight_client ||= Line::Bot::V2::Insight::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def parser
  @parser ||= Line::Bot::V2::WebhookParser.new(channel_secret: ENV.fetch("LINE_CHANNEL_SECRET"))
end

post '/callback' do
  body = request.body.read
  signature = request.env['HTTP_X_LINE_SIGNATURE']

  begin
    events = parser.parse(body, signature)
  rescue Line::Bot::V2::WebhookParser::InvalidSignatureError
    halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request'
  end

  events.each do |event|
    case event
    when Line::Bot::V2::Webhook::MessageEvent
      handle_message_event(event)

    when Line::Bot::V2::Webhook::FollowEvent
      reply_text(event, "[FOLLOW]\nThank you for following")

    when Line::Bot::V2::Webhook::UnfollowEvent
      logger.info "[UNFOLLOW]\n#{body}"

    when Line::Bot::V2::Webhook::JoinEvent
      reply_text(event, "[JOIN]\n#{event.source.type}")

    when Line::Bot::V2::Webhook::LeaveEvent
      logger.info "[LEAVE]\n#{body}"

    when Line::Bot::V2::Webhook::MemberJoinedEvent
      reply_text(event, "[MEMBER JOINED]\n#{event.source.type}")

    when Line::Bot::V2::Webhook::MemberLeftEvent
      logger.info "[MEMBER LEFT]\n#{body}"

    when Line::Bot::V2::Webhook::PostbackEvent
      message = "[POSTBACK]\n#{event.postback.data} (#{JSON.generate(event.postback.params)})"
      reply_text(event, message)

    when Line::Bot::V2::Webhook::BeaconEvent
      reply_text(event, "[BEACON]\n#{JSON.generate(event.beacon)}")

    when Line::Bot::V2::Webhook::AccountLinkEvent
      reply_text(event, "[ACCOUNT LINK]\n#{JSON.generate(event.link)}")

    when Line::Bot::V2::Webhook::ModuleEvent
      reply_text(event, "[MODULE]\n#{JSON.generate(event.module)}")

    when Line::Bot::V2::Webhook::ActivatedEvent
      reply_text(event, "[ACTIVATED]\n#{JSON.generate(event.chat_control)}")

    when Line::Bot::V2::Webhook::DeactivatedEvent
      logger.info "[DEACTIVATED]\n#{body}"

    when Line::Bot::V2::Webhook::BotSuspendedEvent
      logger.info "[BOT SUSPENDED]\n#{body}"

    when Line::Bot::V2::Webhook::BotResumedEvent
      logger.info "[BOT RESUMED]\n#{body}"

    when Line::Bot::V2::Webhook::PnpDeliveryCompletionEvent
      reply_text(event, "[PNP DELIVERY COMPLETE] delivered\n")

    when Line::Bot::V2::Webhook::ThingsEvent
      reply_text(event, "[THINGS]\n#{JSON.generate(event.things)}")

    when Line::Bot::V2::Webhook::VideoPlayCompleteEvent
      reply_text(event, "[VIDEO_PLAY_COMPLETE]\n#{JSON.generate(event.video_play_complete)}")

    when Line::Bot::V2::Event::UnsendEvent
      handle_unsend(event)

    else
      reply_text(event, "Unknown event type: #{event}")
    end
  end

  "OK"
end

def handle_message_event(event)
  message = event.message

  case message
  when Line::Bot::V2::Webhook::ImageMessageContent
    message_id = message.id
    response = blob_client.get_message_content(message_id: message_id)
    tf = Tempfile.open("content")
    tf.write(response.body)
    reply_text(event, "[MessageType::IMAGE]\nid:#{message_id}\nreceived #{tf.size} bytes data")

  when Line::Bot::V2::Webhook::VideoMessageContent
    message_id = message.id
    response = blob_client.get_message_content(message_id: message_id)
    tf = Tempfile.open("content")
    tf.write(response.body)
    reply_text(event, "[MessageType::VIDEO]\nid:#{message_id}\nreceived #{tf.size} bytes data")

  when Line::Bot::V2::Webhook::AudioMessageContent
    message_id = message.id
    response = blob_client.get_message_content(message_id: message_id)
    tf = Tempfile.open("content")
    tf.write(response.body)
    reply_text(event, "[MessageType::AUDIO]\nid:#{message_id}\nreceived #{tf.size} bytes data")

  when Line::Bot::V2::Webhook::FileMessageContent
    message_id = message.id
    response = blob_client.get_message_content(message_id: message_id)
    tf = Tempfile.open("content")
    tf.write(response.body)
    reply_text(event, "[MessageType::FILE]\nid:#{message_id}\nreceived #{tf.size} bytes data")

  when Line::Bot::V2::Webhook::StickerMessageContent
    reply_text(event, "[MessageType::STICKER]\npackage_id: #{message.package_id}\nsticker_id: #{message.sticker_id}")

  when Line::Bot::V2::Webhook::LocationMessageContent
    request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
      reply_token: event.reply_token,
      messages: [
        Line::Bot::V2::MessagingApi::LocationMessage.new(
          title: message.title,
          address: message.address,
          latitude: message.latitude,
          longitude: message.longitude
        )
      ]
    )
    client.reply_message(reply_message_request: request)

  when Line::Bot::V2::Webhook::TextMessageContent
    case event.message.text
    when 'profile'
      if event.source.type == 'user'
        profile_response = client.get_profile(user_id: event.source.user_id)
        reply_text(event, "Display name: #{profile_response.display_name}\nStatus message: #{profile_response.status_message}")
      else
        reply_text(event, "Bot can't use profile API without user ID")
      end

    when 'request id'
      reply_request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(text: "[REPLY] Reply message")
        ]
      )

      _body, _status_code, headers = client.reply_message_with_http_info(reply_message_request: reply_request)

      push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: event.source.user_id,
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(text: "[^Request ID] #{headers['x-line-request-id']}")
        ]
      )
      client.push_message(push_message_request: push_request)

    when 'emoji'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TextMessageV2.new(
            text: "Look at this: {sample} It's a LINE emoji!",
            substitution: {
              sample: {
                "type": "emoji",
                product_id: '5ac1bfd5040ab15980c9b435',
                emoji_id: '001'
              }
            }
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'buttons'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TemplateMessage.new(
            alt_text: 'Buttons alt text',
            template: Line::Bot::V2::MessagingApi::ButtonsTemplate.new(
              thumbnail_image_url: THUMBNAIL_URL,
              title: 'My button sample',
              text: 'Hello, my button',
              actions: [
                Line::Bot::V2::MessagingApi::URIAction.new(
                  label: 'Go to line.me',
                  uri: 'https://line.me',
                  alt_uri: Line::Bot::V2::MessagingApi::AltUri.new(
                    desktop: 'https://line.me#desktop'
                  )
                ),
                Line::Bot::V2::MessagingApi::PostbackAction.new(
                  label: 'Send postback',
                  data: 'hello world',
                ),
                Line::Bot::V2::MessagingApi::PostbackAction.new(
                  label: 'Send postback2',
                  data: 'hello world',
                  text: 'hello world',
                ),
                Line::Bot::V2::MessagingApi::MessageAction.new(
                  label: 'Send message',
                  text: 'This is message',
                ),
              ]
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'confirm'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TemplateMessage.new(
            alt_text: 'Confirm alt text',
            template: Line::Bot::V2::MessagingApi::ConfirmTemplate.new(
              text: 'Do it?',
              actions: [
                Line::Bot::V2::MessagingApi::MessageAction.new(
                  label: 'Yes',
                  text: 'Yes!',
                ),
                Line::Bot::V2::MessagingApi::MessageAction.new(
                  label: 'No',
                  text: 'No!',
                  ),
              ]
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'carousel'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TemplateMessage.new(
            alt_text: 'Carousel alt text',
            template: Line::Bot::V2::MessagingApi::CarouselTemplate.new(
              columns: [
                Line::Bot::V2::MessagingApi::CarouselColumn.new(
                  title: 'hoge',
                  text: 'fuga',
                  actions: [
                    Line::Bot::V2::MessagingApi::URIAction.new(
                      label: 'Go to line.me',
                      uri: 'https://line.me',
                      alt_uri: Line::Bot::V2::MessagingApi::AltUri.new(
                        desktop: 'https://line.me#desktop'
                      )
                    ),
                    Line::Bot::V2::MessagingApi::PostbackAction.new(
                      label: 'Send postback',
                      data: 'hello world',
                    ),
                    Line::Bot::V2::MessagingApi::MessageAction.new(
                      label: 'Send message',
                      text: 'This is message',
                    ),
                  ]
                ),
                Line::Bot::V2::MessagingApi::CarouselColumn.new(
                  title: 'Datetime Picker',
                  text: 'Please select a date, time or datetime',
                  actions: [
                    Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                      label: 'Datetime',
                      data: 'action=sel',
                      mode: 'datetime',
                      initial: '2017-06-18T06:15',
                      max: '2100-12-31T23:59',
                      min: '1900-01-01T00:00'
                    ),
                    Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                      label: 'Date',
                      data: 'action=sel&only=date',
                      mode: 'date',
                      initial: '2017-06-18',
                      max: '2100-12-31',
                      min: '1900-01-01'
                    ),
                    Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                      label: 'Time',
                      data: 'action=sel&only=time',
                      mode: 'time',
                      initial: '12:15',
                      max: '23:00',
                      min: '10:00'
                    ),
                  ]
                )
              ]
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'image carousel'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TemplateMessage.new(
            alt_text: 'Image carousel alt text',
            template: Line::Bot::V2::MessagingApi::ImageCarouselTemplate.new(
              columns: [
                Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
                  image_url: THUMBNAIL_URL,
                  action: Line::Bot::V2::MessagingApi::URIAction.new(
                    label: 'line.me',
                    uri: 'https://line.me',
                    alt_uri: Line::Bot::V2::MessagingApi::AltUri.new(
                      desktop: 'https://line.me#desktop'
                    )
                  )
                ),
                Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
                  image_url: THUMBNAIL_URL,
                  action: Line::Bot::V2::MessagingApi::PostbackAction.new(
                    label: 'postback',
                    data: 'hello world',
                  )
                ),
                Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
                  image_url: THUMBNAIL_URL,
                  action: Line::Bot::V2::MessagingApi::MessageAction.new(
                    text: 'This is message',
                    label: 'message',
                  )
                ),
                Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
                  image_url: THUMBNAIL_URL,
                  action: Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                    label: 'Datetime',
                    data: 'action=sel',
                    mode: 'datetime',
                    initial: '2017-06-18T06:15',
                    max: '2100-12-31T23:59',
                    min: '1900-01-01T00:00'
                  )
                )
              ]
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'imagemap'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::ImagemapMessage.new(
            base_url: THUMBNAIL_URL,
            alt_text: 'Imagemap alt text',
            base_size: Line::Bot::V2::MessagingApi::ImagemapBaseSize.new(
              width: 1024,
              height: 1024
            ),
            actions: [
              Line::Bot::V2::MessagingApi::URIImagemapAction.new(
                link_uri: 'https://store.line.me/family/manga/en',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 0,
                  y: 0,
                  width: 512,
                  height: 512
                )
              ),
              Line::Bot::V2::MessagingApi::URIImagemapAction.new(
                link_uri: 'https://store.line.me/family/music/en',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 512,
                  y: 0,
                  width: 512,
                  height: 512
                )
              ),
                Line::Bot::V2::MessagingApi::URIImagemapAction.new(
                link_uri: 'https://store.line.me/family/play/en',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 0,
                  y: 512,
                  width: 512,
                  height: 512
                )
              ),
              Line::Bot::V2::MessagingApi::MessageImagemapAction.new(
                text: 'Fortune!',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 512,
                  y: 512,
                  width: 512,
                  height: 512
                )
              )
            ]
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'imagemap video'
      video_url = File.join(settings.app_base_url.to_s, 'imagemap/video.mp4')
      preview_url = File.join(settings.app_base_url.to_s, 'imagemap/preview.jpg')

      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::ImagemapMessage.new(
            base_url: THUMBNAIL_URL,
            alt_text: 'Imagemap video text',
            base_size: Line::Bot::V2::MessagingApi::ImagemapBaseSize.new(
              width: 1040,
              height: 1040
            ),
            video: Line::Bot::V2::MessagingApi::ImagemapVideo.new(
              original_content_url: video_url,
              preview_image_url: preview_url,
              area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                x: 0,
                y: 0,
                width: 520,
                height: 520
              ),
              external_link: Line::Bot::V2::MessagingApi::ImagemapExternalLink.new(
                link_uri: 'https://line.me',
                label: 'LINE'
              )
            ),
            actions: [
              Line::Bot::V2::MessagingApi::URIImagemapAction.new(
                link_uri: 'https://store.line.me/family/manga/en',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 0,
                  y: 0,
                  width: 512,
                  height: 512
                )
              ),
              Line::Bot::V2::MessagingApi::URIImagemapAction.new(
                link_uri: 'https://store.line.me/family/music/en',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 512,
                  y: 0,
                  width: 512,
                  height: 512
                )
              ),
              Line::Bot::V2::MessagingApi::URIImagemapAction.new(
                link_uri: 'https://store.line.me/family/play/en',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 0,
                  y: 512,
                  width: 512,
                  height: 512
                )
              ),
              Line::Bot::V2::MessagingApi::MessageImagemapAction.new(
                text: 'Fortune!',
                area: Line::Bot::V2::MessagingApi::ImagemapArea.new(
                  x: 512,
                  y: 512,
                  width: 512,
                  height: 512
                )
              )
            ]
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'flex'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'this is a flex message',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              header: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(
                    text: 'Header text'
                  )
                ]
              ),
              hero: Line::Bot::V2::MessagingApi::FlexImage.new(
                url: HORIZONTAL_THUMBNAIL_URL,
                size: 'full',
                aspect_ratio: '4:3',
              ),
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(
                    text: 'Body text'
                  )
                ]
              ),
              footer: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(
                    text: 'Footer text',
                    align: 'center',
                    color: '#888888'
                  )
                ]
              )
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'flex carousel'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'this is a flex carousel',
            contents: Line::Bot::V2::MessagingApi::FlexCarousel.new(
              contents: [
                Line::Bot::V2::MessagingApi::FlexBubble.new(
                  body: Line::Bot::V2::MessagingApi::FlexBox.new(
                    layout: 'horizontal',
                    contents: [
                      Line::Bot::V2::MessagingApi::FlexText.new(
                        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        wrap: true
                      )
                    ]
                  ),
                  footer: Line::Bot::V2::MessagingApi::FlexBox.new(
                    layout: 'horizontal',
                    contents: [
                      Line::Bot::V2::MessagingApi::FlexButton.new(
                        style: 'primary',
                        action: Line::Bot::V2::MessagingApi::URIAction.new(
                          label: 'Go',
                          uri: 'https://example.com',
                          alt_uri: Line::Bot::V2::MessagingApi::AltUri.new(
                            desktop: 'https://example.com#desktop'
                          )
                        )
                      )
                    ]
                  )
                ),
                Line::Bot::V2::MessagingApi::FlexBubble.new(
                  body: Line::Bot::V2::MessagingApi::FlexBox.new(
                    layout: 'horizontal',
                    contents: [
                      Line::Bot::V2::MessagingApi::FlexText.new(
                        text: "Hello, World!",
                        wrap: true
                      )
                    ]
                  ),
                  footer: Line::Bot::V2::MessagingApi::FlexBox.new(
                    layout: 'horizontal',
                    contents: [
                      Line::Bot::V2::MessagingApi::FlexButton.new(
                        style: 'primary',
                        action: Line::Bot::V2::MessagingApi::URIAction.new(
                          label: 'Go',
                          uri: 'https://example.com',
                          alt_uri: Line::Bot::V2::MessagingApi::AltUri.new(
                            desktop: 'https://example.com#desktop'
                          )
                        )
                      )
                    ]
                  )
                )
              ]
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'quick reply'
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: '[QUICK REPLY]',
            quick_reply: Line::Bot::V2::MessagingApi::QuickReply.new(
              items: [
                Line::Bot::V2::MessagingApi::QuickReplyItem.new(
                  action: Line::Bot::V2::MessagingApi::MessageAction.new(
                    label: 'Sushi',
                    text: 'Sushi'
                  )
                ),
                Line::Bot::V2::MessagingApi::QuickReplyItem.new(
                  image_url: QUICK_REPLY_ICON_URL,
                  action: Line::Bot::V2::MessagingApi::LocationAction.new(
                    label: 'Send location'
                  )
                ),
                Line::Bot::V2::MessagingApi::QuickReplyItem.new(
                  image_url: QUICK_REPLY_ICON_URL,
                  action: Line::Bot::V2::MessagingApi::CameraAction.new(
                    label: 'Open camera'
                  )
                ),
                Line::Bot::V2::MessagingApi::QuickReplyItem.new(
                  image_url: QUICK_REPLY_ICON_URL,
                  action: Line::Bot::V2::MessagingApi::CameraRollAction.new(
                    label: 'Open camera roll'
                  )
                ),
                Line::Bot::V2::MessagingApi::QuickReplyItem.new(
                  action: Line::Bot::V2::MessagingApi::PostbackAction.new(
                    label: 'buy',
                    data: "action=buy&itemid=111",
                    text: "buy"
                  )
                ),
                Line::Bot::V2::MessagingApi::QuickReplyItem.new(
                  action: Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                    type: "datetimepicker",
                    label: "Select date",
                    data: "storeId=12345",
                    mode: "datetime",
                    initial: "2017-12-25t00:00",
                    max: "2018-01-24t23:59",
                    min: "2017-12-25t00:00"
                  )
                )
              ]
            )
          )
        ]
      )
      client.reply_message(reply_message_request: request)

    when 'bye'
      case event.source.type
      when 'user'
        request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
          reply_token: event.reply_token,
          messages: [
            Line::Bot::V2::MessagingApi::TextMessage.new(text: "[BYE]\nBot can't leave from 1:1 chat")
          ]
        )
        client.reply_message(reply_message_request: request)
      when 'group'
        request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
          reply_token: event.reply_token,
          messages: [
            Line::Bot::V2::MessagingApi::TextMessage.new(text: "[BYE]\nLeaving group")
          ]
        )
        client.reply_message(reply_message_request: request)

        client.leave_group(group_id: event.source.group_id)
      when 'room'
        request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
          reply_token: event.reply_token,
          messages: [
            Line::Bot::V2::MessagingApi::TextMessage.new(text: "[BYE]\nLeaving room")
          ]
        )
        client.reply_message(reply_message_request: request)

        client.leave_room(group_id: event.source.room_id)
      end

    when 'stats'
      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TemplateMessage.new(
            alt_text: 'stats',
            template: Line::Bot::V2::MessagingApi::ButtonsTemplate.new(
              thumbnail_image_url: THUMBNAIL_URL,
              title: 'Stats sample',
              text: 'Hello, my stats',
              actions: [
                Line::Bot::V2::MessagingApi::URIAction.new(
                  label: 'Go to line.me',
                  uri: 'https://line.me',
                  alt_uri: Line::Bot::V2::MessagingApi::AltUri.new(
                    desktop: 'https://line.me#desktop'
                  )
                ),
                Line::Bot::V2::MessagingApi::PostbackAction.new(
                  label: 'Send postback',
                  data: 'hello world'
                ),
                Line::Bot::V2::MessagingApi::PostbackAction.new(
                  label: 'Send postback2',
                  data: 'hello world',
                  text: 'hello world'
                ),
                Line::Bot::V2::MessagingApi::MessageAction.new(
                  label: 'Send message',
                  text: 'This is message'
                )
              ]
            )
          )
        ]
      )
      response = client.broadcast(broadcast_request: request)
      request_id = response.header['X-Line-Request-Id']

      reply_text(event, "RequestId: #{request_id}")

    when /\Astats\s+(?<request_id>.+)/
      request_id = Regexp.last_match[:request_id]
      stats = insight_client.get_message_event(request_id: request_id)

      reply_text(event, "[STATS]\n#{stats}")

    else
      reply_text(event, "[ECHO]\n#{event.message.text}")
    end
  else
    logger.info "Unknown message type: #{event.type}"
    reply_text(event, "[UNKNOWN]\n#{event.type}")
  end
end

def reply_text(event, text)
  request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
    reply_token: event.reply_token,
    messages: [
      Line::Bot::V2::MessagingApi::TextMessage.new(text: text)
    ]
  )
  client.reply_message(reply_message_request: request)
end

