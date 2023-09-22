require 'sinatra'
require 'line-bot-api'

before do
  LINE::Client::MessagingApi.configure do |config|
    config.access_token = ENV.fetch('LINE_CHANNEL_TOKEN')
  end
end

def client
  LINE::Client::MessagingApi::MessagingApiApi.new
end

post '/callback' do
  body           = request.body.read
  signature      = request.env['HTTP_X_LINE_SIGNATURE']
  channel_secret = ENV.fetch('LINE_CHANNEL_SECRET')

  unless LINE::Client::Webhook.validate_signature(body, signature, channel_secret)
    halt 400
  end

  events = LINE::Client::Webhook.parse_events_from(body)

  events.each do |event|
    case event
    when LINE::Client::Webhook::MessageEvent
      case event.message['type']
      when 'text'
        request = LINE::Client::MessagingApi::ReplyMessageRequest.new(
          reply_token: event.reply_token,
          messages: [
            {
              type: 'text',
              text: event.message['text']
            }
          ]
        )
        begin
          client.reply_message(request)
        rescue LINE::Client::MessagingApi::ApiError => e
          puts "Error when calling MessagingApiApi#reply_message: #{e}"
        end
      end
    end
  end

  'OK'
end
