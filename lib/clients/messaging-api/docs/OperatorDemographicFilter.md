# LINE::Client::MessagingApi::OperatorDemographicFilter

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **_and** | [**Array&lt;DemographicFilter&gt;**](DemographicFilter.md) |  | [optional] |
| **_or** | [**Array&lt;DemographicFilter&gt;**](DemographicFilter.md) |  | [optional] |
| **_not** | [**DemographicFilter**](DemographicFilter.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::OperatorDemographicFilter.new(
  _and: null,
  _or: null,
  _not: null
)
```

