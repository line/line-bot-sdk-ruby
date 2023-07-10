# LINE::Client::MessagingApi::QuickReplyItem

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **image_url** | **String** | URL of the icon that is displayed at the beginning of the button | [optional] |
| **action** | [**Action**](Action.md) |  | [optional] |
| **type** | **String** | &#x60;action&#x60; | [optional][default to &#39;action&#39;] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::QuickReplyItem.new(
  image_url: null,
  action: null,
  type: null
)
```

