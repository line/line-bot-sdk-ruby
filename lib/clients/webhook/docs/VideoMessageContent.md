# LINE::Client::Webhook::VideoMessageContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **duration** | **Integer** | Length of video file (milliseconds) | [optional] |
| **content_provider** | [**ContentProvider**](ContentProvider.md) |  |  |
| **quote_token** | **String** | Quote token to quote this message.  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::VideoMessageContent.new(
  id: null,
  duration: null,
  content_provider: null,
  quote_token: null
)
```

