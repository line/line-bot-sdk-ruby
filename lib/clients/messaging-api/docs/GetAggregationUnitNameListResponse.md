# LINE::Client::MessagingApi::GetAggregationUnitNameListResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **custom_aggregation_units** | **Array&lt;String&gt;** | An array of strings indicating the names of aggregation units used this month. |  |
| **_next** | **String** | A continuation token to get the next array of unit names. Returned only when there are remaining aggregation units that weren&#39;t returned in customAggregationUnits in the original request.   | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::GetAggregationUnitNameListResponse.new(
  custom_aggregation_units: null,
  _next: null
)
```

