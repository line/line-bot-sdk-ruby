# LINE::Client::MessagingApi::TestWebhookEndpointResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **success** | **Boolean** | Result of the communication from the LINE platform to the webhook URL. | [optional] |
| **timestamp** | **Time** | Time of the event in milliseconds. Even in the case of a redelivered webhook, it represents the time the event occurred, not the time it was redelivered.  |  |
| **status_code** | **Integer** | The HTTP status code. If the webhook response isn&#39;t received, the status code is set to zero or a negative number. |  |
| **reason** | **String** | Reason for the response. |  |
| **detail** | **String** | Details of the response. |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::TestWebhookEndpointResponse.new(
  success: null,
  timestamp: null,
  status_code: null,
  reason: null,
  detail: null
)
```

