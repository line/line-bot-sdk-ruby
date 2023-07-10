# LINE::Client::Webhook::BeaconEventAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | Reply token used to send reply message to this event |  |
| **beacon** | [**BeaconContent**](BeaconContent.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::BeaconEventAllOf.new(
  reply_token: null,
  beacon: null
)
```

