# LINE::Client::MessagingApi::FlexImage

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **url** | **String** | Image URL (Max character limit: 2000) Protocol: HTTPS (TLS 1.2 or later) Image format: JPEG or PNG Maximum image size: 1024×1024 pixels Maximum file size: 10 MB (300 KB when the animated property is true)  |  |
| **flex** | **Integer** | The ratio of the width or height of this component within the parent box. | [optional] |
| **margin** | **String** | The minimum amount of space to include before this component in its parent container.  | [optional] |
| **position** | **String** | Reference for offsetTop, offsetBottom, offsetStart, and offsetEnd. Specify one of the following values:  &#x60;relative&#x60;: Use the previous box as reference. &#x60;absolute&#x60;: Use the top left of parent element as reference. The default value is relative.  | [optional] |
| **offset_top** | **String** | Offset. | [optional] |
| **offset_bottom** | **String** | Offset. | [optional] |
| **offset_start** | **String** | Offset. | [optional] |
| **offset_end** | **String** | Offset. | [optional] |
| **align** | **String** | Alignment style in horizontal direction.  | [optional] |
| **gravity** | **String** | Alignment style in vertical direction. | [optional] |
| **size** | **String** | The maximum image width. This is md by default.  | [optional][default to &#39;md&#39;] |
| **aspect_ratio** | **String** | Aspect ratio of the image. &#x60;{width}:{height}&#x60; format. Specify the value of &#x60;{width}&#x60; and &#x60;{height}&#x60; in the range from &#x60;1&#x60; to &#x60;100000&#x60;. However, you cannot set &#x60;{height}&#x60; to a value that is more than three times the value of &#x60;{width}&#x60;. The default value is &#x60;1:1&#x60;.  | [optional] |
| **aspect_mode** | **String** | The display style of the image if the aspect ratio of the image and that specified by the aspectRatio property do not match.  | [optional] |
| **background_color** | **String** | Background color of the image. Use a hexadecimal color code. | [optional] |
| **action** | [**Action**](Action.md) |  | [optional] |
| **animated** | **Boolean** | When this is &#x60;true&#x60;, an animated image (APNG) plays. You can specify a value of true up to 10 images in a single message. You can&#39;t send messages that exceed this limit. This is &#x60;false&#x60; by default. Animated images larger than 300 KB aren&#39;t played back.  | [optional][default to false] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::FlexImage.new(
  url: null,
  flex: null,
  margin: null,
  position: null,
  offset_top: null,
  offset_bottom: null,
  offset_start: null,
  offset_end: null,
  align: null,
  gravity: null,
  size: null,
  aspect_ratio: null,
  aspect_mode: null,
  background_color: null,
  action: null,
  animated: null
)
```

