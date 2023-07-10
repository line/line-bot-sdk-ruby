# LINE::Client::Webhook::ImageSet

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Image set ID. Only included when multiple images are sent simultaneously. | [optional] |
| **index** | **Integer** | An index starting from 1, indicating the image number in a set of images sent simultaneously. Only included when multiple images are sent simultaneously. However, it won&#39;t be included if the sender is using LINE 11.15 or earlier for Android. | [optional] |
| **total** | **Integer** | The total number of images sent simultaneously. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ImageSet.new(
  id: null,
  index: null,
  total: null
)
```

