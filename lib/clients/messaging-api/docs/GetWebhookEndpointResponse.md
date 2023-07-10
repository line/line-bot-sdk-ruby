# LINE::Client::MessagingApi::GetWebhookEndpointResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **endpoint** | **String** | Webhook URL |  |
| **active** | **Boolean** | Webhook usage status. Send a webhook event from the LINE Platform to the webhook URL only if enabled.  &#x60;true&#x60;: Webhook usage is enabled. &#x60;false&#x60;: Webhook usage is disabled.  |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::GetWebhookEndpointResponse.new(
  endpoint: null,
  active: null
)
```

