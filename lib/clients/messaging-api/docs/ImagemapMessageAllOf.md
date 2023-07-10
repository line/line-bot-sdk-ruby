# LINE::Client::MessagingApi::ImagemapMessageAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **base_url** | **String** |  | [optional] |
| **alt_text** | **String** |  | [optional] |
| **base_size** | [**ImagemapBaseSize**](ImagemapBaseSize.md) |  | [optional] |
| **actions** | [**Array&lt;ImagemapAction&gt;**](ImagemapAction.md) |  | [optional] |
| **video** | [**ImagemapVideo**](ImagemapVideo.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::ImagemapMessageAllOf.new(
  base_url: null,
  alt_text: null,
  base_size: null,
  actions: null,
  video: null
)
```

