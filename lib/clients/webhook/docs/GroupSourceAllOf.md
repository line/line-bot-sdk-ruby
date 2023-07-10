# LINE::Client::Webhook::GroupSourceAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID of the source group chat |  |
| **user_id** | **String** | ID of the source user. Only included in message events. Only users of LINE for iOS and LINE for Android are included in userId. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::GroupSourceAllOf.new(
  group_id: null,
  user_id: null
)
```

