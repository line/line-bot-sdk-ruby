# LINE::Client::Webhook::VideoMessageContentAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **duration** | **Integer** | Length of video file (milliseconds) | [optional] |
| **content_provider** | [**ContentProvider**](ContentProvider.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::VideoMessageContentAllOf.new(
  id: null,
  duration: null,
  content_provider: null
)
```

