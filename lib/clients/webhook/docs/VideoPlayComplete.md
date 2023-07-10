# LINE::Client::Webhook::VideoPlayComplete

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **tracking_id** | **String** | ID used to identify a video. Returns the same value as the trackingId assigned to the video message. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::VideoPlayComplete.new(
  tracking_id: null
)
```

