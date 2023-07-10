# LINE::Client::Webhook::TextMessageContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **text** | **String** | Message text. |  |
| **emojis** | [**Array&lt;Emoji&gt;**](Emoji.md) | Array of one or more LINE emoji objects. Only included in the message event when the text property contains a LINE emoji. | [optional] |
| **mention** | [**Mention**](Mention.md) |  | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::TextMessageContent.new(
  id: null,
  text: null,
  emojis: null,
  mention: null
)
```

