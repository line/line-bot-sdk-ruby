# LINE::Client::MessagingApi::StickerMessage

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **package_id** | **String** |  | [optional] |
| **sticker_id** | **String** |  | [optional] |
| **quote_token** | **String** | Quote token of the message you want to quote. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::StickerMessage.new(
  package_id: null,
  sticker_id: null,
  quote_token: null
)
```

