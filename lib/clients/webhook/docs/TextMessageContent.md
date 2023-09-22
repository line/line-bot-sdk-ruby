# LINE::Client::Webhook::TextMessageContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **text** | **String** | Message text. |  |
| **emojis** | [**Array&lt;Emoji&gt;**](Emoji.md) | Array of one or more LINE emoji objects. Only included in the message event when the text property contains a LINE emoji. | [optional] |
| **mention** | [**Mention**](Mention.md) |  | [optional] |
| **quote_token** | **String** | Quote token to quote this message.  |  |
| **quoted_message_id** | **String** | Message ID of a quoted message. Only included when the received message quotes a past message. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::TextMessageContent.new(
  id: null,
  text: null,
  emojis: null,
  mention: null,
  quote_token: null,
  quoted_message_id: null
)
```

