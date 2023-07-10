# LINE::Client::Insight::GetMessageEventResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **overview** | [**GetMessageEventResponseOverview**](GetMessageEventResponseOverview.md) |  | [optional] |
| **messages** | [**Array&lt;GetMessageEventResponseMessage&gt;**](GetMessageEventResponseMessage.md) | Array of information about individual message bubbles. | [optional] |
| **clicks** | [**Array&lt;GetMessageEventResponseClick&gt;**](GetMessageEventResponseClick.md) | Array of information about opened URLs in the message. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetMessageEventResponse.new(
  overview: null,
  messages: null,
  clicks: null
)
```

