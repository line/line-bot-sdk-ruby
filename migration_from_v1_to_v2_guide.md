# Migration Guide: From v1 to v2

Users can perform the migration step at their own pace. Follow these steps:

1. Upgrade the `line-bot-api` gem to `1.30.0`.
2. Migrate v1 code to v2 code. All v1 code issues deprecation warnings, so please migrate until they are gone. Since v1.30.0 includes all v1 and v2 code, you don't have to replace everything at once. You can switch gradually.
3. Once all code is switched, upgrade `line-bot-api` to `2.0.0` or above.

## Change all v1 implementations to v2 implementations in v1.30.0
**v1.30.0 includes both the v1 and v2 codebases.**

When you use the v1 code in v1.30.0, you will see deprecation warnings such as:

```
[DEPRECATION] Line::Bot::Client#push_message is deprecated. Please use Line::Bot::V2::MessagingApi::ApiClient#push_message instead.
```

These warnings indicate which methods to use in the new v2 code.

Alternatively, the YARD documentation/comments also clearly indicate where to migrate.
```rb
# https://github.com/line/line-bot-sdk-ruby/blob/fb449ba19201a57c5f58dcd19ea67c5a53b0a0fe/lib/line/bot/v1/client.rb#L277-L288

# @deprecated
# This is deprecated.
# Please use {Line::Bot::V2::MessagingApi::ApiClient#push_message} instead.
#
# Push messages to a user using user_id.
#
# @param user_id [String] User Id
# @param messages [Hash, Array] Message Objects
# @param headers [Hash] HTTP Headers
# @param payload [Hash] Additional request body
# @return [Net::HTTPResponse]
def push_message(user_id, messages, headers: {}, payload: {})
```

**Once v1 code usage is completely removed in v1.30.0, please switch to v2.0.0 >= version immediately.**  
Starting with v2.0.0, v1 code is not included.

## Suppress deprecation warnings
You can suppress the deprecation warning by setting any value to `ENV['SUPRESS_V1_DEPRECATION_WARNINGS']`.


However, it's not recommended to always use it as it could lead to migration errors.

## Clients
There are several types of API clients.
Depending on the classification of the API, there are several types of clients.
- `MassagingAPI`.
- `ManageAudience`
- `Inshight`
- `ChannelAccessToken`
- `Liff`
- `Shop`
  and so on.

In addition, the same `MessagingAPI` is divided into `ApiBlobClient` for APIs that use https://api-data.line.me to upload and download files.

- `Line::Bot::V2::MessagingAPI::ApiClient`.
- `Line::Bot::V2::MessagingAPI::ApiBlobClient`.

These are planned to be integrated in the future, but this has not yet been accomplished.


## Migration examples
Only typical examples are shown here.
Please refer to Examples in the next chapter for more examples.

### Calling API
#### v1
```rb
client = Line::Bot::Client.new do |config|
  config.channel_token = ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
end

response = client.push_message(
  'U1234567890abcdef1234567890abcdef',
  [
    {
      type: 'text',
      text: 'Hello, this is a test message!'
    }
  ]
)

puts response.class # => Net::HTTPResponse
```
#### v2 (with class)
```rb
client = Line::Bot::V2::MessagingApi::ApiClient.new(
  channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
)

message = Line::Bot::V2::MessagingAPI::TextMessage.new( # No need to pass `type: "text"`
  text: 'Hello, this is a test message!'
)

request = Line::Bot::V2::MessagingAPI::PushMessageRequest.new(
  to: 'U1234567890abcdef1234567890abcdef',
  messages: [
    message
  ]
)

response, status_code, response_headers = client.push_message_with_http_info(
  push_message_request: request
)

puts response.class # => Line::Bot::V2::MessagingAPI::PushMessageResponse
```
#### v2 (with Hash)
This is not a recommended way.
Please use one of the above methods if possible.

However, this method makes migration from v1 easier.

```rb
client = Line::Bot::V2::MessagingApi::ApiClient.new(
  channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
)

request = Line::Bot::V2::MessagingAPI::PushMessageRequest.new(
  to: 'U1234567890abcdef1234567890abcdef',
  messages: [
    {
      type: 'text',
      text: 'Hello, this is a test message!'
    }
  ]
)

response, status_code, response_headers = client.push_message_with_http_info(
  push_message_request: request
)

puts response.class # => Line::Bot::V2::MessagingAPI::PushMessageResponse
```
### Handling Webhook
#### v1
```rb
require 'sinatra' 
require 'line/bot' 

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    halt 400, {'Content-Type' => 'text/plain'}, 'Bad Request'
  end

  events = client.parse_events_from(body)

  events.each do |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = {
          type: 'text',
          text: event.message['text']
        }
        client.reply_message(event['replyToken'], message)
      end
    end
  end

  "OK"
end
```
#### v2
```rb
require 'sinatra'
require 'line-bot-api'

set :environment, :production

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
  signature = request.env['HTTP_X_LINE_SIGNATURE']

  begin
    events = parser.parse(body: body, signature: signature)
  rescue Line::Bot::V2::WebhookParser::InvalidSignatureError
    halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request'
  end

  events.each do |event|
    case event
    when Line::Bot::V2::Webhook::MessageEvent
      case event.message
      when Line::Bot::V2::Webhook::TextMessageContent
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
  end

  "OK"
end
```
