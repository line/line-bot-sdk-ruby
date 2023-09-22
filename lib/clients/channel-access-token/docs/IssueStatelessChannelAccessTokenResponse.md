# LINE::Client::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | A stateless channel access token. The token is an opaque string which means its format is an implementation detail and the consumer of this token should never try to use the data parsed from the token.  |  |
| **expires_in** | **Integer** | Duration in seconds after which the issued access token expires |  |
| **token_type** | **String** | Token type. The value is always &#x60;Bearer&#x60;. | [default to &#39;Bearer&#39;] |

## Example

```ruby
require 'line_client_channel_access_token'

instance = LINE::Client::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse.new(
  access_token: null,
  expires_in: null,
  token_type: null
)
```

