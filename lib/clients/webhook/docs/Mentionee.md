# LINE::Client::Webhook::Mentionee

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Mentioned target. | [optional] |
| **index** | **Integer** | Index position of the user mention for a character in text, with the first character being at position 0. |  |
| **length** | **Integer** | The length of the text of the mentioned user. For a mention @example, 8 is the length. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::Mentionee.new(
  type: null,
  index: null,
  length: null
)
```

