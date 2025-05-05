require 'sinatra'
require 'line-bot-api'

set :environment, :production
set :app_base_url, ENV.fetch('APP_BASE_URL')

def client
  @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
  )
end

def parser
  @parser ||= Line::Bot::V2::WebhookParser.new(channel_secret: ENV.fetch("LINE_CHANNEL_SECRET"))
end

configure do
  webhook_endpoint = "#{settings.app_base_url}/callback"
  body, code, _ = client.set_webhook_endpoint_with_http_info(set_webhook_endpoint_request: Line::Bot::V2::MessagingApi::SetWebhookEndpointRequest.new(
    endpoint: webhook_endpoint
  ))

  if code == 200
    p "✅ LINE Webhook URL set to #{webhook_endpoint}"
  else
    p "❌ Failed to set LINE Webhook. code=#{code}, error body=#{body}"
  end
end

post '/callback' do
  body = request.body.read
  signature = request.env['HTTP_X_LINE_SIGNATURE']

  begin
    events = parser.parse(body: body, signature: signature)
  rescue Line::Bot::V2::WebhookParser::InvalidSignatureError
    halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request'
  end

  events.each do |event|
    if event.is_a?(Line::Bot::V2::Webhook::MessageEvent) && event.message.is_a?(Line::Bot::V2::Webhook::TextMessageContent)
      message = event.message.text
      request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
        reply_token: event.reply_token,
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(text: message)
        ]
      )
      client.reply_message(reply_message_request: request)
    end
  end

  "OK"
end
