# LINE::Bot::API

LINE::Bot::API - SDK of the LINE BOT API Trial for Ruby

## Configuration

```
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

```
client.send_text(
  to_mid: '12345678',
)
client.send_text(
  to_mid: ['12345678', '23456789'],
)
```

#### send_text

```
client.send_text(
  to_mid: to_mid,
  text: 'Hello',
)
```

#### send_image

```
client.send_image(
  to_mid: to_mid,
  image_url: 'http://example.com/image.jpg',            # originalContentUrl
  preview_url: 'http://example.com/image_preview.jpg',  # previewImageUrl
)
```

#### send_video

```
client.send_video(
  to_mid: to_mid,
  video_url: 'http://example.com/video.mp4',            # originalContentUrl
  preview_url: 'http://example.com/video_preview.jpg'   # previewImageUrl
)
```

#### send_audio

```
client.send_audio(
  to_mid: to_mid,
  audio_url: 'http://example.com/audio.mp3',            # originalContentUrl
  duration: 120000
)
```

#### send_location

```
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

```
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

```
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

```
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

```
request = Rack::Request.new( .. )
signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
unless client.validate_signature(request.body.read, signature)
  return 'invalidation of signature'
end
```

### Receiving request

```
request_from_rack = Rack::Request.new( .. )

request = Line::Bot::Receive::Request.new(request_from_rack.env)
request.data #=> [Array] Line::Bot::Receive::Message || Line::Bot::Receive::Operation

request.data.each { |message|
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

```
user_profile = client.get_user_profile("1234567")
user_profile #=> [Line::Bot::Response::User::Profile]
contacts = user_profile.contacts
contacts #=> [Array] Line::Bot::Response::User::Contacts
```

## License

The gem is available as open source under the terms of the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0).

## Links

- [https://business.line.me/](https://business.line.me/)
- [https://developers.line.me/bot-api/overview](https://developers.line.me/bot-api/overview)
- [https://developers.line.me/bot-api/getting-started-with-bot-api-trial](https://developers.line.me/bot-api/getting-started-with-bot-api-trial)
