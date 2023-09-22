# LINE::Client::Webhook::ImageMessageContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **content_provider** | [**ContentProvider**](ContentProvider.md) |  |  |
| **image_set** | [**ImageSet**](ImageSet.md) |  | [optional] |
| **quote_token** | **String** | Quote token to quote this message.  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ImageMessageContent.new(
  id: null,
  content_provider: null,
  image_set: null,
  quote_token: null
)
```

