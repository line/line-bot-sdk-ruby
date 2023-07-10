# LINE::Client::Shop::MissionStickerRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **to** | **String** | Destination user ID |  |
| **product_id** | **String** | Package ID for a set of stickers |  |
| **product_type** | **String** | &#x60;STICKER&#x60; |  |
| **send_present_message** | **Boolean** | &#x60;false&#x60; |  |

## Example

```ruby
require 'line_client_shop'

instance = LINE::Client::Shop::MissionStickerRequest.new(
  to: null,
  product_id: null,
  product_type: STICKER,
  send_present_message: false
)
```

