# LINE::Client::MessagingApi::PushMessageRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **to** | **String** | ID of the receiver. |  |
| **messages** | [**Array&lt;Message&gt;**](Message.md) | List of Message objects. |  |
| **notification_disabled** | **Boolean** | &#x60;true&#x60;: The user doesn’t receive a push notification when a message is sent. &#x60;false&#x60;: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false.  | [optional][default to false] |
| **custom_aggregation_units** | **Array&lt;String&gt;** | List of aggregation unit name. Case-sensitive. This functions can only be used by corporate users who have submitted the required applications.  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::PushMessageRequest.new(
  to: null,
  messages: null,
  notification_disabled: null,
  custom_aggregation_units: null
)
```

