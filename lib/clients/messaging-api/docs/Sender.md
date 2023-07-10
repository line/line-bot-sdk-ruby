# LINE::Client::MessagingApi::Sender

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Display name. Certain words such as &#x60;LINE&#x60; may not be used. | [optional] |
| **icon_url** | **String** | URL of the image to display as an icon when sending a message | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::Sender.new(
  name: null,
  icon_url: null
)
```

