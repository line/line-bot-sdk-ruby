# LINE::Client::Webhook::PostbackEventAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | Reply token used to send reply message to this event | [optional] |
| **postback** | [**PostbackContent**](PostbackContent.md) |  | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::PostbackEventAllOf.new(
  reply_token: null,
  postback: null
)
```

