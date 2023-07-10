# LINE::Client::ChannelAccessToken::ErrorResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** | Error summary | [optional] |
| **error_description** | **String** | Details of the error. Not returned in certain situations. | [optional] |

## Example

```ruby
require 'line_client_channel_access_token'

instance = LINE::Client::ChannelAccessToken::ErrorResponse.new(
  error: null,
  error_description: null
)
```

