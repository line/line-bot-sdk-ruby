# Line::Bot::API

[![Gem-version](https://img.shields.io/gem/v/line-bot-api.svg)](https://rubygems.org/gems/line-bot-api) [![Build Status](https://travis-ci.org/line/line-bot-sdk-ruby.svg?branch=master)](https://travis-ci.org/line/line-bot-sdk-ruby)


Line::Bot::API - SDK of the LINE Messaging API for Ruby.

## About LINE Messaging API

Please refer to the official api documents for details.

https://devdocs.line.me/

## Synopsis

usage is:

```ruby
# app.rb
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
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = {
          type: 'text',
          text: event.message['text']
        }
        client.reply(event['replyToken'], message)
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'line-bot-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install line-bot-api

## License

   Copyright (C) 2016 LINE Corporation.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
