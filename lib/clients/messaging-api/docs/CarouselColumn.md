# LINE::Client::MessagingApi::CarouselColumn

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **thumbnail_image_url** | **String** |  | [optional] |
| **image_background_color** | **String** |  | [optional] |
| **title** | **String** |  | [optional] |
| **text** | **String** |  | [optional] |
| **default_action** | [**Action**](Action.md) |  | [optional] |
| **actions** | [**Array&lt;Action&gt;**](Action.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::CarouselColumn.new(
  thumbnail_image_url: null,
  image_background_color: null,
  title: null,
  text: null,
  default_action: null,
  actions: null
)
```

