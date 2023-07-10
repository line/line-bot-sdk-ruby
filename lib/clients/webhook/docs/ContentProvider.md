# LINE::Client::Webhook::ContentProvider

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Provider of the image file. |  |
| **original_content_url** | **String** | URL of the image file. Only included when contentProvider.type is external. | [optional] |
| **preview_image_url** | **String** | URL of the preview image. Only included when contentProvider.type is external. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ContentProvider.new(
  type: null,
  original_content_url: null,
  preview_image_url: null
)
```

