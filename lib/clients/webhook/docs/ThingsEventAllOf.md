# LINE::Client::Webhook::ThingsEventAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | Reply token used to send reply message to this event |  |
| **things** | [**ThingsContent**](ThingsContent.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ThingsEventAllOf.new(
  reply_token: null,
  things: null
)
```

