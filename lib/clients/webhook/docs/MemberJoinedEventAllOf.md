# LINE::Client::Webhook::MemberJoinedEventAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | Reply token used to send reply message to this event |  |
| **joined** | [**JoinedMembers**](JoinedMembers.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::MemberJoinedEventAllOf.new(
  reply_token: null,
  joined: null
)
```

