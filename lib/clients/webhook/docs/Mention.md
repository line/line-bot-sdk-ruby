# LINE::Client::Webhook::Mention

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **mentionees** | [**Array&lt;Mentionee&gt;**](Mentionee.md) | Array of one or more mention objects. Max: 20 mentions |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::Mention.new(
  mentionees: null
)
```

