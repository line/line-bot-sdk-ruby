# LINE::Client::Webhook::AudioMessageContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **content_provider** | [**ContentProvider**](ContentProvider.md) |  |  |
| **duration** | **Integer** | Length of audio file (milliseconds) | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::AudioMessageContent.new(
  id: null,
  content_provider: null,
  duration: null
)
```

