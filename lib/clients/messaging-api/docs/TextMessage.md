# LINE::Client::MessagingApi::TextMessage

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **text** | **String** |  | [optional] |
| **emojis** | [**Array&lt;Emoji&gt;**](Emoji.md) |  | [optional] |
| **quote_token** | **String** | Quote token of the message you want to quote. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::TextMessage.new(
  text: null,
  emojis: null,
  quote_token: null
)
```

