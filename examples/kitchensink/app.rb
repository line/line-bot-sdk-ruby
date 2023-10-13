require 'sinatra'   # gem 'sinatra'
require 'line-bot-api'

THUMBNAIL_URL = 'https://via.placeholder.com/1024x1024'
HORIZONTAL_THUMBNAIL_URL = 'https://via.placeholder.com/1024x768'
QUICK_REPLY_ICON_URL = 'https://via.placeholder.com/64x64'

set :app_base_url, ENV['APP_BASE_URL']

before do
  LINE::Client::MessagingApi.configure do |config|
    config.access_token = ENV.fetch('LINE_CHANNEL_TOKEN')
  end
  LINE::Client::Insight.configure do |config|
    config.access_token = ENV.fetch('LINE_CHANNEL_TOKEN')
  end
end

channel_secret = ENV.fetch('LINE_CHANNEL_SECRET')

def client
  @client ||= LINE::Client::MessagingApi::MessagingApiApi.new
end

def blob_client
  @blob_client ||= LINE::Client::MessagingApi::MessagingApiBlobApi.new
end

def insight_client
  @insight_client ||= LINE::Client::Insight::InsightApi.new
end

def reply_text(event, texts)
  texts = [texts] if texts.is_a?(String)
  client.reply_message(LINE::Client::MessagingApi::ReplyMessageRequest.new(
    reply_token: event.reply_token,
    messages: texts.map { |text| {type: 'text', text: text} }
  ))
end

def broadcast(messages)
  client.broadcast_with_http_info(LINE::Client::MessagingApi::BroadcastRequest.new(
    messages: messages
  ))
end

def reply_content(event, messages)
  client.reply_message(LINE::Client::MessagingApi::ReplyMessageRequest.new(
    reply_token: event.reply_token,
    messages: messages
  ))
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless LINE::Client::Webhook.validate_signature(body, signature, channel_secret)
    halt 400
  end

  events = LINE::Client::Webhook.parse_events_from(body)

  events.each do |event|
    case event
    when LINE::Client::Webhook::MessageEvent
      handle_message(event)

    when LINE::Client::Webhook::FollowEvent
      reply_text(event, "[FOLLOW]\nThank you for following")

    when Line::Client::Webhook::UnfollowEvent
      logger.info "[UNFOLLOW]\n#{body}"

    when Line::Client::Webhook::JoinEvent
      reply_text(event, "[JOIN]\n#{event['source']['type']}")

    when Line::Client::Webhook::LeaveEvent
      logger.info "[LEAVE]\n#{body}"

    when Line::Client::Webhook::PostbackEvent
      message = "[POSTBACK]\n#{event['postback']['data']} (#{JSON.generate(event['postback']['params'])})"
      reply_text(event, message)

    when Line::Client::Webhook::BeaconEvent
      reply_text(event, "[BEACON]\n#{JSON.generate(event['beacon'])}")

    when Line::Client::Webhook::ThingsEvent
      reply_text(event, "[THINGS]\n#{JSON.generate(event['things'])}")

    when Line::Client::Webhook::VideoPlayCompleteEvent
      reply_text(event, "[VIDEOPLAYCOMPLETE]\n#{JSON.generate(event['videoPlayComplete'])}")

    when Line::Client::Webhook::UnsendEvent
      handle_unsend(event)

    else
      reply_text(event, "Unknown event type: #{event}")
    end
  end

  "OK"
end

def handle_message(event)
  logger.info "Received message: #{event.message['type']}"

  case event.message['type']
  when 'image'
    message_id = event.message['id']
    response = blob_client.get_message_content(message_id)
    reply_text(event, "[MessageType::IMAGE]\nid:#{message_id}\nreceived #{response.size} bytes data")
  when 'video'
    message_id = event.message['id']
    response = blob_client.get_message_content(message_id)
    reply_text(event, "[MessageType::VIDEO]\nid:#{message_id}\nreceived #{response.size} bytes data")
  when 'audio'
    message_id = event.message['id']
    response = blob_client.get_message_content(message_id)
    tf = Tempfile.open("content")
    tf.write(response.body)
    reply_text(event, "[MessageType::AUDIO]\nid:#{message_id}\nreceived #{tf.size} bytes data")
  when 'file'
    message_id = event.message['id']
    response = blob_client.get_message_content(message_id)
    reply_text(event, "[MessageType::FILE]\nid:#{message_id}\nfileName:#{event.message['fileName']}\nfileSize:#{event.message['fileSize']}\nreceived #{response.size} bytes data")
  when 'sticker'
    handle_sticker(event)
  when 'location'
    handle_location(event)
  when 'text'
    case event.message['text']
    when 'profile'
      if event.source['type'] == 'user'
        profile = client.get_profile(event.source['user_id'])
        reply_text(event, [
          "Display name\n#{profile.display_name}",
          "Status message\n#{profile.status_message}"
        ])
      else
        reply_text(event, "Bot can't use profile API without user ID")
      end

    when 'emoji'
      reply_content(event, [{
        type: 'text',
        text: 'Look at this: $ It\'s a LINE emoji!',
        emojis: [
          {
              index: 14,
              productId: '5ac1bfd5040ab15980c9b435',
              emojiId: '001'
          }
        ]
      }])

    when 'buttons'
      reply_content(event, [{
        type: 'template',
        altText: 'Buttons alt text',
        template: {
          type: 'buttons',
          thumbnailImageUrl: THUMBNAIL_URL,
          title: 'My button sample',
          text: 'Hello, my button',
          actions: [
            { label: 'Go to line.me', type: 'uri', uri: 'https://line.me', altUri: {desktop: 'https://line.me#desktop'} },
            { label: 'Send postback', type: 'postback', data: 'hello world' },
            { label: 'Send postback2', type: 'postback', data: 'hello world', text: 'hello world' },
            { label: 'Send message', type: 'message', text: 'This is message' }
          ]
        }
      }])

    when 'confirm'
      reply_content(event, [{
        type: 'template',
        altText: 'Confirm alt text',
        template: {
          type: 'confirm',
          text: 'Do it?',
          actions: [
            { label: 'Yes', type: 'message', text: 'Yes!' },
            { label: 'No', type: 'message', text: 'No!' },
          ],
        }
      }])

    when 'carousel'
      reply_content(event, [{
        type: 'template',
        altText: 'Carousel alt text',
        template: {
          type: 'carousel',
          columns: [
            {
              title: 'hoge',
              text: 'fuga',
              actions: [
                { label: 'Go to line.me', type: 'uri', uri: 'https://line.me', altUri: {desktop: 'https://line.me#desktop'} },
                { label: 'Send postback', type: 'postback', data: 'hello world' },
                { label: 'Send message', type: 'message', text: 'This is message' }
              ]
            },
            {
              title: 'Datetime Picker',
              text: 'Please select a date, time or datetime',
              actions: [
                {
                  type: 'datetimepicker',
                  label: "Datetime",
                  data: 'action=sel',
                  mode: 'datetime',
                  initial: '2017-06-18T06:15',
                  max: '2100-12-31T23:59',
                  min: '1900-01-01T00:00'
                },
                {
                  type: 'datetimepicker',
                  label: "Date",
                  data: 'action=sel&only=date',
                  mode: 'date',
                  initial: '2017-06-18',
                  max: '2100-12-31',
                  min: '1900-01-01'
                },
                {
                  type: 'datetimepicker',
                  label: "Time",
                  data: 'action=sel&only=time',
                  mode: 'time',
                  initial: '12:15',
                  max: '23:00',
                  min: '10:00'
                }
              ]
            }
          ]
        }
      }])

    when 'image carousel'
      reply_content(event, [{
        type: 'template',
        altText: 'Image carousel alt text',
        template: {
          type: 'image_carousel',
          columns: [
            {
              imageUrl: THUMBNAIL_URL,
              action: { label: 'line.me', type: 'uri', uri: 'https://line.me', altUri: {desktop: 'https://line.me#desktop'} }
            },
            {
              imageUrl: THUMBNAIL_URL,
              action: { label: 'postback', type: 'postback', data: 'hello world' }
            },
            {
              imageUrl: THUMBNAIL_URL,
              action: { label: 'message', type: 'message', text: 'This is message' }
            },
            {
              imageUrl: THUMBNAIL_URL,
              action: {
                type: 'datetimepicker',
                label: "Datetime",
                data: 'action=sel',
                mode: 'datetime',
                initial: '2017-06-18T06:15',
                max: '2100-12-31T23:59',
                min: '1900-01-01T00:00'
              }
            }
          ]
        }
      }])

    when 'imagemap'
      reply_content(event, [{
        type: 'imagemap',
        baseUrl: THUMBNAIL_URL,
        altText: 'Imagemap alt text',
        baseSize: { width: 1024, height: 1024 },
        actions: [
          { area: { x: 0, y: 0, width: 512, height: 512 }, type: 'uri', linkUri: 'https://store.line.me/family/manga/en' },
          { area: { x: 512, y: 0, width: 512, height: 512 }, type: 'uri', linkUri: 'https://store.line.me/family/music/en' },
          { area: { x: 0, y: 512, width: 512, height: 512 }, type: 'uri', linkUri: 'https://store.line.me/family/play/en' },
          { area: { x: 512, y: 512, width: 512, height: 512 }, type: 'message', text: 'Fortune!' },
        ]
      }])

    when 'imagemap video'
      video_url = File.join(settings.app_base_url.to_s, 'imagemap/video.mp4')
      preview_url = File.join(settings.app_base_url.to_s, 'imagemap/preview.jpg')
      reply_content(event, [{
        type: 'imagemap',
        baseUrl: THUMBNAIL_URL,
        altText: 'Imagemap alt text',
        baseSize: { width: 1040, height: 1040 },
        video: {
          originalContentUrl: video_url,
          previewImageUrl: preview_url,
          area: {
            x: 0,
            y: 0,
            width: 520,
            height: 520,
          },
          external_link: {
            linkUri: 'https://line.me',
            label: 'LINE',
          },
        },
        actions: [
          { area: { x: 0, y: 0, width: 512, height: 512 }, type: 'uri', linkUri: 'https://store.line.me/family/manga/en' },
          { area: { x: 512, y: 0, width: 512, height: 512 }, type: 'uri', linkUri: 'https://store.line.me/family/music/en' },
          { area: { x: 0, y: 512, width: 512, height: 512 }, type: 'uri', linkUri: 'https://store.line.me/family/play/en' },
          { area: { x: 512, y: 512, width: 512, height: 512 }, type: 'message', text: 'Fortune!' },
        ]
      }])

    when 'flex'
      reply_content(event, [{
        type: "flex",
        altText: "this is a flex message",
        contents: {
          type: "bubble",
          header: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: "Header text"
              }
            ]
          },
          hero: {
            type: "image",
            url: HORIZONTAL_THUMBNAIL_URL,
            size: "full",
            aspectRatio: "4:3"
          },
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: "Body text",
              }
            ]
          },
          footer: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "text",
                text: "Footer text",
                align: "center",
                color: "#888888"
              }
            ]
          }
        }
      }])

    when 'flex carousel'
      reply_content(event, [{
        type: "flex",
        altText: "this is a flex carousel",
        contents: {
          type: "carousel",
          contents: [
            {
              type: "bubble",
              body: {
                type: "box",
                layout: "horizontal",
                contents: [
                  {
                    type: "text",
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    wrap: true
                  }
                ]
              },
              footer: {
                type: "box",
                layout: "horizontal",
                contents: [
                  {
                    type: "button",
                    style: "primary",
                    action: {
                      type: "uri",
                      label: "Go",
                      uri: "https://example.com",
                      altUri: {
                        desktop: "https://example.com#desktop"
                      },
                    }
                  }
                ]
              }
            },
            {
              type: "bubble",
              body: {
                type: "box",
                layout: "horizontal",
                contents: [
                  {
                    type: "text",
                    text: "Hello, World!",
                    wrap: true
                  }
                ]
              },
              footer: {
                type: "box",
                layout: "horizontal",
                contents: [
                  {
                    type: "button",
                    style: "primary",
                    action: {
                      type: "uri",
                      label: "Go",
                      uri: "https://example.com",
                      altUri: {
                        desktop: "https://example.com#desktop"
                      }
                    }
                  }
                ]
              }
            }
          ]
        }
      }])

    when 'quickreply'
      reply_content(event, [{
        type: 'text',
        text: '[QUICK REPLY]',
        quickReply: {
          items: [
            {
              type: "action",
              imageUrl: QUICK_REPLY_ICON_URL,
              action: {
                type: "message",
                label: "Sushi",
                text: "Sushi"
              }
            },
            {
              type: "action",
              action: {
                type: "location",
                label: "Send location"
              }
            },
            {
              type: "action",
              imageUrl: QUICK_REPLY_ICON_URL,
              action: {
                type: "camera",
                label: "Open camera",
              }
            },
            {
              type: "action",
              imageUrl: QUICK_REPLY_ICON_URL,
              action: {
                type: "cameraRoll",
                label: "Open cameraRoll",
              }
            },
            {
              type: "action",
              action: {
                type: "postback",
                label: "buy",
                data: "action=buy&itemid=111",
                text: "buy",
              }
            },
            {
              type: "action",
              action: {
                type: "message",
                label: "Yes",
                text: "Yes"
              }
            },
            {
              type: "action",
              action: {
                type: "datetimepicker",
                label: "Select date",
                data: "storeId=12345",
                mode: "datetime",
                initial: "2017-12-25t00:00",
                max: "2018-01-24t23:59",
                min: "2017-12-25t00:00"
              }
            },
          ],
        },
      }])

    when 'bye'
      case event.source['type']
      when 'user'
        reply_text(event, "[BYE]\nBot can't leave from 1:1 chat")
      when 'group'
        reply_text(event, "[BYE]\nLeaving group")
        client.leave_group(event.source['group_id'])
      when 'room'
        reply_text(event, "[BYE]\nLeaving room")
        client.leave_room(event.source['room_id'])
      end

    when 'stats'
      data, status_code, headers = broadcast([{
        type: 'template',
        altText: 'stats',
        template: {
          type: 'buttons',
          thumbnailImageUrl: THUMBNAIL_URL,
          title: 'stats sample',
          text: 'Hello, my stats',
          actions: [
            { label: 'Go to line.me', type: 'uri', uri: 'https://line.me', altUri: {desktop: 'https://line.me#desktop'} },
            { label: 'Send postback', type: 'postback', data: 'hello world' },
            { label: 'Send postback2', type: 'postback', data: 'hello world', text: 'hello world' },
            { label: 'Send message', type: 'message', text: 'This is message' }
          ]
        }
      }])
      logger.info "data=#{data} status=#{status_code} headers=#{headers}"
      request_id = headers["X-Line-Request-Id"]
      reply_text(event, "RequestId: #{request_id}")

    when /\Astats\s+(?<request_id>.+)/
      request_id = Regexp.last_match[:request_id]
      stats = insight_client.get_message_event(request_id)
      reply_text(event, "[STATS]\n#{stats}")

    else
      reply_text(event, "[ECHO]\n#{event.message['text']}")

    end
  else
    logger.info "Unknown message type: #{event.type}"
    reply_text(event, "[UNKNOWN]\n#{event.type}")
  end
end

def handle_sticker(event)
  # Message API available stickers
  # https://developers.line.biz/en/docs/messaging-api/sticker-list/
  msgapi_available = [
    446, 789, 1070, 6136, 6325, 6359, 6362, 6370,
    6632, 8515, 8522, 8525, 11537, 11538, 11539
  ].include?(event.message['package_id'].to_i)
  messages = [{
    type: 'text',
    text: "[STICKER]\npackageId: #{event.message['package_id']}\nstickerId: #{event.message['sticker_id']}"
  }]
  if msgapi_available
    messages.push(
      type: 'sticker',
      packageId: event.message['package_id'],
      stickerId: event.message['sticker_id']
    )
  end
  reply_content(event, messages)
end

def handle_location(event)
  message = event.message
  reply_content(event, [{
    type: 'location',
    title: message['title'] || message['address'],
    address: message['address'],
    latitude: message['latitude'],
    longitude: message['longitude']
  }])
end

def handle_unsend(event)
  source = event['source']
  id = case source['type']
  when 'user'
    source['userId']
  when 'group'
    source['groupId']
  when 'room'
    source['roomId']
  end
  client.push_message(id, {
    type: 'text',
    text: "[UNSEND]\nmessageId: #{event['unsend']['messageId']}"
  })
end
