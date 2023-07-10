# LINE::Client::MessagingApi::ImagemapVideo

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **original_content_url** | **String** |  | [optional] |
| **preview_image_url** | **String** |  | [optional] |
| **area** | [**ImagemapArea**](ImagemapArea.md) |  | [optional] |
| **external_link** | [**ImagemapExternalLink**](ImagemapExternalLink.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::ImagemapVideo.new(
  original_content_url: null,
  preview_image_url: null,
  area: null,
  external_link: null
)
```

