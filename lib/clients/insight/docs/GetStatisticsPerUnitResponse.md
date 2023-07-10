# LINE::Client::Insight::GetStatisticsPerUnitResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **overview** | [**GetStatisticsPerUnitResponseOverview**](GetStatisticsPerUnitResponseOverview.md) |  |  |
| **messages** | [**Array&lt;GetStatisticsPerUnitResponseMessage&gt;**](GetStatisticsPerUnitResponseMessage.md) | Array of information about individual message bubbles. |  |
| **clicks** | [**Array&lt;GetStatisticsPerUnitResponseClick&gt;**](GetStatisticsPerUnitResponseClick.md) | Array of information about opened URLs in the message. |  |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetStatisticsPerUnitResponse.new(
  overview: null,
  messages: null,
  clicks: null
)
```

