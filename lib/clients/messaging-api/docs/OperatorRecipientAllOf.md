# LINE::Client::MessagingApi::OperatorRecipientAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_and** | [**Array&lt;Recipient&gt;**](Recipient.md) | Create a new recipient object by taking the logical conjunction (AND) of the specified array of recipient objects.  | [optional] |
| **_or** | [**Array&lt;Recipient&gt;**](Recipient.md) | Create a new recipient object by taking the logical disjunction (OR) of the specified array of recipient objects.  | [optional] |
| **_not** | [**Recipient**](Recipient.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::OperatorRecipientAllOf.new(
  _and: null,
  _or: null,
  _not: null
)
```

