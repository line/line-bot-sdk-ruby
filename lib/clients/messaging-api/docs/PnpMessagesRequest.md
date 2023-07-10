# LINE::Client::MessagingApi::PnpMessagesRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **messages** | [**Array&lt;Message&gt;**](Message.md) | Message to be sent. |  |
| **to** | **String** | Message destination. Specify a phone number that has been normalized to E.164 format and hashed with SHA256. |  |
| **notification_disabled** | **Boolean** | &#x60;true&#x60;: The user doesn’t receive a push notification when a message is sent. &#x60;false&#x60;: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false.  | [optional][default to false] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::PnpMessagesRequest.new(
  messages: null,
  to: null,
  notification_disabled: null
)
```

