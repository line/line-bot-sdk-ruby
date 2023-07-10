# LINE::Client::MessagingApi::ReplyMessageRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | replyToken received via webhook. |  |
| **messages** | [**Array&lt;Message&gt;**](Message.md) | List of messages. |  |
| **notification_disabled** | **Boolean** | &#x60;true&#x60;: The user doesn’t receive a push notification when a message is sent. &#x60;false&#x60;: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false.  | [optional][default to false] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::ReplyMessageRequest.new(
  reply_token: null,
  messages: null,
  notification_disabled: null
)
```

