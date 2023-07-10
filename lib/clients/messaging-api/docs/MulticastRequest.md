# LINE::Client::MessagingApi::MulticastRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **messages** | [**Array&lt;Message&gt;**](Message.md) | Messages to send |  |
| **to** | **Array&lt;String&gt;** | Array of user IDs. Use userId values which are returned in webhook event objects. Do not use LINE IDs found on LINE. |  |
| **notification_disabled** | **Boolean** | &#x60;true&#x60;: The user doesn’t receive a push notification when a message is sent. &#x60;false&#x60;: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false.  | [optional][default to false] |
| **custom_aggregation_units** | **Array&lt;String&gt;** | Name of aggregation unit. Case-sensitive. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::MulticastRequest.new(
  messages: null,
  to: null,
  notification_disabled: null,
  custom_aggregation_units: null
)
```

