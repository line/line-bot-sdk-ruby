# Line::Bot::API

[![Gem-version](https://img.shields.io/gem/v/line-bot-api.svg)](https://rubygems.org/gems/line-bot-api) [![Build Status](https://travis-ci.org/line/line-bot-sdk-ruby.svg?branch=master)](https://travis-ci.org/line/line-bot-sdk-ruby)


Line::Bot::API - SDK of the LINE BOT API Trial for Ruby

```ruby
# app.rb
require 'sinatra'
require 'line/bot'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_id = ENV["LINE_CHANNEL_ID"]
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_mid = ENV["LINE_CHANNEL_MID"]
  }
end

post '/callback' do
  signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
  unless client.validate_signature(request.body.read, signature)
    error 400 do 'Bad Request' end
  end

  receive_request = Line::Bot::Receive::Request.new(request.env)

  receive_request.data.each { |message|
    case message.content
    when Line::Bot::Message::Text
      client.send_text(
        to_mid: message.from_mid,
        text: message.content[:text],
      )
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

## Configuration

```ruby
client = Line::Bot::Client.new do |config|
  config.channel_id = 'YOUR LINE BOT Channel ID'
  config.channel_secret = 'YOUR LINE BOT Channel Secret'
  config.channel_mid = 'YOUR LINE BOT MID'
end
```

## Usage

### Sending messages

After configuring a client, you can start sending messages as the following reference.

- [https://developers.line.me/bot-api/api-reference#sending_message](https://developers.line.me/bot-api/api-reference#sending_message)

Sending message APIs requires the following parameter.
- `:to_mid` String or Array

```ruby
client.send_text(
  to_mid: '12345678',
)
client.send_text(
  to_mid: ['12345678', '23456789'],
)
```

#### send_text

```ruby
client.send_text(
  to_mid: to_mid,
  text: 'Hello',
)
```

#### send_image

```ruby
client.send_image(
  to_mid: to_mid,
  image_url: 'http://example.com/image.jpg',            # originalContentUrl
  preview_url: 'http://example.com/image_preview.jpg',  # previewImageUrl
)
```

#### send_video

```ruby
client.send_video(
  to_mid: to_mid,
  video_url: 'http://example.com/video.mp4',            # originalContentUrl
  preview_url: 'http://example.com/video_preview.jpg'   # previewImageUrl
)
```

#### send_audio

```ruby
client.send_audio(
  to_mid: to_mid,
  audio_url: 'http://example.com/audio.mp3',            # originalContentUrl
  duration: 120000
)
```

#### send_location

```ruby
client.send_location(
  to_mid: to_mid,
  title: 'LINE Corporation.',
  address: 'Hikarie  Shibuya-ku Tokyo 151-0002',        # location.address
  latitude: 35.61823286112982,                          # location.latitude
  longitude: 139.72824096679688,                        # location.longitude
)
```

#### send_sticker

See online documentation to find which sticker's you can send.

- [https://developers.line.me/bot-api/api-reference#sending_message_sticker](https://developers.line.me/bot-api/api-reference#sending_message_sticker)

```ruby
client.send_sticker(
  to_mid: to_mid,
  stkpkgid: 2,                                          # contentMetadata.STKPKGID
  stkid: 144,                                           # contentMetadata.STKID
  stkver: 100                                           # contentMetadata.STKVER
)
```

### Sending multiple message

Support on sending multiple message.
- [https://developers.line.me/bot-api/api-reference#sending_multiple_messages](https://developers.line.me/bot-api/api-reference#sending_multiple_messages)

```ruby
client.multiple_message.add_text(
  text: text,
).add_image(
  image_url: image_url,
  preview_url: preview_url,
).add_video(
  video_url: video_url,
  preview_url: preview_url,
).add_audio(
  audio_url: audio_url,
  duration: duration,
).add_location(
  title: 'title',
  latitude: latitude,
  longitude: longitude,
).add_sticker(
  stkpkgid: stkpkgid,
  stkid: stkid,
  stkver: stkver,
).send(
  to_mid: to_mid,
)
```

### Sending rich message

Support on sending rich message.

See also a online document.
- [https://developers.line.me/bot-api/api-reference#sending_rich_content_message](https://developers.line.me/bot-api/api-reference#sending_rich_content_message)

```ruby
client.rich_message.set_action(
  MANGA: {
    text: 'manga',
    link_url: link_url,
  }
).add_listener(
  action: 'MANGA',
  x: 0,
  y: 0,
  width: 520,
  height: 520,
).send(
  to_mid: to_mid,
  image_url: image_url,
  alt_text: alt_text,
)
```

### Signature validation

```ruby
request = Rack::Request.new( .. )
signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
unless client.validate_signature(request.body.read, signature)
  return 'invalidation of signature'
end
```

### Receiving request

```ruby
request = Rack::Request.new( .. )

receive_request = Line::Bot::Receive::Request.new(request.env)
receive_request.data #=> [Array<Line::Bot::Receive::Message || Line::Bot::Receive::Operation>]

receive_request.data.each { |message|
  case message.content
  when Line::Bot::Message::Image, Line::Bot::Message::Video
    # get message content
    response = client.get_message_content(message.id)
    tf = Tempfile.open("content")
    tf.write(response.body)

    # get preview of message content
    preview_response = client.get_message_content_preview(message.id)
    ptf = Tempfile.open("content_preview")
    ptf.write(preview_response.body)
  end
}
```

### Getting message content

Get the original file which was sent by user.

### Getting preview of message content

Get the preview image file which was sent by user.

### Getting user profile information

```ruby
user_profile = client.get_user_profile("1234567")
user_profile #=> [Line::Bot::Response::User::Profile]
user_profile.contacts #=> [Array<Line::Bot::Response::User::Contact>]
```

## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0).

## Links

- [https://business.line.me/](https://business.line.me/)
- [https://developers.line.me/bot-api/overview](https://developers.line.me/bot-api/overview)
- [https://developers.line.me/bot-api/getting-started-with-bot-api-trial](https://developers.line.me/bot-api/getting-started-with-bot-api-trial)
