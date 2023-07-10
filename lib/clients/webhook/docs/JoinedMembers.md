# LINE::Client::Webhook::JoinedMembers

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **members** | [**Array&lt;UserSource&gt;**](UserSource.md) | Users who joined. Array of source user objects. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::JoinedMembers.new(
  members: null
)
```

