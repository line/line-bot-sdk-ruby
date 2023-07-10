# LINE::Client::Webhook::ThingsEvent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | Reply token used to send reply message to this event |  |
| **things** | [**ThingsContent**](ThingsContent.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ThingsEvent.new(
  reply_token: null,
  things: null
)
```

