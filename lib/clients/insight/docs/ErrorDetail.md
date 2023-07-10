# LINE::Client::Insight::ErrorDetail

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message** | **String** | Details of the error. Not included in the response under certain situations. | [optional] |
| **property** | **String** | Location of where the error occurred. Returns the JSON field name or query parameter name of the request. Not included in the response under certain situations. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::ErrorDetail.new(
  message: null,
  property: null
)
```

