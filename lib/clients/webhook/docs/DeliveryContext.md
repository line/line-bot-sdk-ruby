# LINE::Client::Webhook::DeliveryContext

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **is_redelivery** | **Boolean** | Whether the webhook event is a redelivered one or not. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::DeliveryContext.new(
  is_redelivery: null
)
```

