# LINE::Client::MessagingApi::SentMessage

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | ID of the sent message. |  |
| **quote_token** | **String** | Quote token of the message. Only included when a message object that can be specified as a quote target was sent as a push or reply message.  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::SentMessage.new(
  id: null,
  quote_token: null
)
```

