# LINE::Client::Webhook::LeftMembers

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **members** | [**Array&lt;UserSource&gt;**](UserSource.md) | Users who left. Array of source user objects. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::LeftMembers.new(
  members: null
)
```

