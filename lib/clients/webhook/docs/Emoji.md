# LINE::Client::Webhook::Emoji

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **index** | **Integer** | Index position for a character in text, with the first character being at position 0. |  |
| **length** | **Integer** | The length of the LINE emoji string. For LINE emoji (hello), 7 is the length. |  |
| **product_id** | **String** | Product ID for a LINE emoji set. |  |
| **emoji_id** | **String** | ID for a LINE emoji inside a set. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::Emoji.new(
  index: null,
  length: null,
  product_id: null,
  emoji_id: null
)
```

