# LINE::Client::Webhook::Event

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Type of the event | [optional] |
| **source** | [**Source**](Source.md) |  | [optional] |
| **timestamp** | **Integer** | Time of the event in milliseconds. |  |
| **mode** | [**EventMode**](EventMode.md) |  |  |
| **webhook_event_id** | **String** | Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format. |  |
| **delivery_context** | [**DeliveryContext**](DeliveryContext.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::Event.new(
  type: null,
  source: null,
  timestamp: null,
  mode: null,
  webhook_event_id: null,
  delivery_context: null
)
```

