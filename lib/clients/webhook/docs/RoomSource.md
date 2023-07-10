# LINE::Client::Webhook::RoomSource

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | ID of the source user. Only included in message events. Only users of LINE for iOS and LINE for Android are included in userId. | [optional] |
| **room_id** | **String** | Room ID of the source multi-person chat |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::RoomSource.new(
  user_id: null,
  room_id: null
)
```

