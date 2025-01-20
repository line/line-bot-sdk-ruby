# LINE Messaging API SDK for Ruby

[![Gem-version](https://img.shields.io/gem/v/line-bot-api.svg)](https://rubygems.org/gems/line-bot-api)


## Introduction
The LINE Messaging API SDK for Ruby makes it easy to develop bots using LINE Messaging API, and you can create a sample bot within minutes.

## Documentation

See the official API documentation for more information

- English: https://developers.line.biz/en/docs/messaging-api/overview/
- Japanese: https://developers.line.biz/ja/docs/messaging-api/overview/

Also, generated documentation by YARD is available.

- https://rubydoc.info/gems/line-bot-api

## Requirements
This library requires Ruby 3.1 or later.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'line-bot-api'
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install line-bot-api
```

## Synopsis

### Basic Usage

```ruby
# app.rb
require 'sinatra'
require 'line/bot'

set :environment, :production

def client
  @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN")
  )
end

def blob_client
  @blob_client ||= Line::Bot::V2::MessagingApi::ApiBlobClient.new(
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
    events = parser.parse(body, signature)
  rescue Line::Bot::V2::WebhookParser::InvalidSignatureError
    halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request'
  end

  events.each do |event|
    case event
    when Line::Bot::V2::Webhook::MessageEvent
      case event.message
      when Line::Bot::V2::Webhook::TextMessageContent
        case event.message.text
        when 'profile'
          if event.source.type == 'user'
            profile_response = client.get_profile(user_id: event.source.user_id)
            reply_text(event, "Display name: #{profile_response.display_name}\nStatus message: #{profile_response.status_message}")
          else
            reply_text(event, "Bot can't use profile API without user ID")
          end
        else
          request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
            reply_token: event.reply_token,
            messages: [
              Line::Bot::V2::MessagingApi::TextMessage.new(text: "[ECHO] #{event.message.text}")
            ]
          )
          client.reply_message(reply_message_request: request)
        end
        
      when Line::Bot::V2::Webhook::ImageMessageContent, Line::Bot::V2::Webhook::VideoMessageContent
        response = blob_client.get_message_content(message_id: event.message.message_id)
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  end

  # Don't forget to return a successful response
  "OK"
end
```

### Use HTTP Information
You may need to store the ```x-line-request-id``` header obtained as a response from several APIs.\
In this case, please use ```*_with_http_info``` methods. You can get headers and status codes.\
The `x-line-accepted-request-id` or `content-type` header can also be obtained in the same way.

```ruby
push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
  to: event.source.user_id,
  messages: [
    Line::Bot::V2::MessagingApi::TextMessage.new(type: 'text', text: "[^Request ID] #{headers['x-line-request-id']}")
  ]
)
_body, _status_code, headers = client.push_message_with_http_info(push_message_request: push_request)

puts headers['x-line-request-id']
puts headers['x-line-accepted-request-id']
puts headers['content-type']
```

### Error handling
If an API call fails, the SDK does not generate an Error in Ruby; use the status code for proper error handling.
Error details are stored in body.

```ruby
require 'json'
require 'line/bot'

def client
  @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def main
  dummy_message = Line::Bot::V2::MessagingApi::TextMessage.new(
    text: "Hello, world!",
  )

  valid_request = Line::Bot::V2::MessagingApi::ValidateMessageRequest.new(
    messages: [dummy_message, dummy_message, dummy_message, dummy_message, dummy_message],
  )
  body, status_code, _headers = client.validate_push_with_http_info(validate_message_request: valid_request)
  handle_response(body, status_code)

  invalid_request = Line::Bot::V2::MessagingApi::ValidateMessageRequest.new(
    messages: [dummy_message, dummy_message, dummy_message, dummy_message, dummy_message, dummy_message],
  )
  body, status_code, _headers = client.validate_push_with_http_info(validate_message_request: invalid_request)
  handle_response(body, status_code)
end

def handle_response(body, status_code)
  case status_code
  when 200
    puts "Valid"
  when 400..499
    puts "Invalid: #{JSON.parse(body)}"
  else
    puts "Other Status: #{status_code}"
  end
end

main
```

### More examples
See the [examples](examples/v2) directory for more examples.

### RBS
This library provides RBS files for type checking.\
You can code with type support in the corresponding IDE or editor.

## Media
News: https://developers.line.biz/en/news/

## Versioning
This project respects semantic versioning.

See https://semver.org/

### v1 and v2
v1 and v2 are completely different implementations, v1 is all deprecated and will be removed in the future.
Migration to v2 is strongly recommended.

#### Deprecation warnings
When calling the API endpoint with v1, a deprecation warning will occur.\
If you want to suppress this, please set any value to the environment variable `SUPRESS_V1_DEPRECATION_WARNINGS`.


## Contributing
Please check [CONTRIBUTING](CONTRIBUTING.md) before making a contribution.

## License
```
Copyright (C) 2016 LINE Corp.
 
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
   http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
