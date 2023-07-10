# LINE::Client::MessagingApi::ErrorDetail

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message** | **String** | Details of the error. Not included in the response under certain situations. | [optional] |
| **property** | **String** | Location of where the error occurred. Returns the JSON field name or query parameter name of the request. Not included in the response under certain situations. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::ErrorDetail.new(
  message: null,
  property: null
)
```

