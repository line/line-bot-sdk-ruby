# LINE::Client::MessagingApi::NarrowcastRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **messages** | [**Array&lt;Message&gt;**](Message.md) | List of Message objects. |  |
| **recipient** | [**Recipient**](Recipient.md) |  | [optional] |
| **filter** | [**Filter**](Filter.md) |  | [optional] |
| **limit** | [**Limit**](Limit.md) |  | [optional] |
| **notification_disabled** | **Boolean** | &#x60;true&#x60;: The user doesn’t receive a push notification when a message is sent. &#x60;false&#x60;: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false.  | [optional][default to false] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::NarrowcastRequest.new(
  messages: null,
  recipient: null,
  filter: null,
  limit: null,
  notification_disabled: null
)
```

