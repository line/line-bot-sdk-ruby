# LINE::Client::Webhook::ImageMessageContentAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **content_provider** | [**ContentProvider**](ContentProvider.md) |  |  |
| **image_set** | [**ImageSet**](ImageSet.md) |  | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ImageMessageContentAllOf.new(
  id: null,
  content_provider: null,
  image_set: null
)
```

