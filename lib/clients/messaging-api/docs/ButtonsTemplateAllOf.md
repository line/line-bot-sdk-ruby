# LINE::Client::MessagingApi::ButtonsTemplateAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **thumbnail_image_url** | **String** |  | [optional] |
| **image_aspect_ratio** | **String** |  | [optional] |
| **image_size** | **String** |  | [optional] |
| **image_background_color** | **String** |  | [optional] |
| **title** | **String** |  | [optional] |
| **text** | **String** |  | [optional] |
| **default_action** | [**Action**](Action.md) |  | [optional] |
| **actions** | [**Array&lt;Action&gt;**](Action.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::ButtonsTemplateAllOf.new(
  thumbnail_image_url: null,
  image_aspect_ratio: null,
  image_size: null,
  image_background_color: null,
  title: null,
  text: null,
  default_action: null,
  actions: null
)
```

