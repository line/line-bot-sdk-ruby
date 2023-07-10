# LINE::Client::Webhook::MessageEventAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** |  | [optional] |
| **message** | [**MessageContent**](MessageContent.md) |  | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::MessageEventAllOf.new(
  reply_token: null,
  message: null
)
```

