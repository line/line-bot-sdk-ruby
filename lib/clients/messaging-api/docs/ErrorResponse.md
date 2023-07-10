# LINE::Client::MessagingApi::ErrorResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message** | **String** | Message containing information about the error. |  |
| **details** | [**Array&lt;ErrorDetail&gt;**](ErrorDetail.md) | An array of error details. If the array is empty, this property will not be included in the response. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::ErrorResponse.new(
  message: null,
  details: null
)
```

