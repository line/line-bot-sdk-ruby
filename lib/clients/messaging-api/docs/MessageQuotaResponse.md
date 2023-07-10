# LINE::Client::MessagingApi::MessageQuotaResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | [**QuotaType**](QuotaType.md) |  |  |
| **value** | **Integer** | The target limit for sending messages in the current month. This property is returned when the &#x60;type&#x60; property has a value of &#x60;limited&#x60;.  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::MessageQuotaResponse.new(
  type: null,
  value: null
)
```

