# LINE::Client::MessagingApi::Message

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Type of message |  |
| **quick_reply** | [**QuickReply**](QuickReply.md) |  | [optional] |
| **sender** | [**Sender**](Sender.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::Message.new(
  type: null,
  quick_reply: null,
  sender: null
)
```

