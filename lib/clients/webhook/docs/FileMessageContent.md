# LINE::Client::Webhook::FileMessageContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **file_name** | **String** | File name |  |
| **file_size** | **Integer** | File size in bytes |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::FileMessageContent.new(
  id: null,
  file_name: null,
  file_size: null
)
```

