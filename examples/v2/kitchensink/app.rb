require 'json'
require 'sinatra'
require 'line/bot'

def client
  @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
  )
end

def parser
  @parser ||= Line::Bot::V2::WebhookParser.new(channel_secret: ENV.fetch("LINE_CHANNEL_SECRET"))
end

post '/callback' do
  body = request.body.read

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
end

def reply_text(event, text)
  request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
    reply_token: event.reply_token,
    messages: [
      Line::Bot::V2::MessagingApi::TextMessage.new(type: 'text', text: text)
    ]
  )
  client.reply_message(reply_message_request: request)
end

def handle_message_event(event)

end
