# LINE::Client::ChannelAccessToken::IssueShortLivedChannelAccessTokenResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | A short-lived channel access token. Valid for 30 days. Note: Channel access tokens cannot be refreshed.  |  |
| **expires_in** | **Integer** | Time until channel access token expires in seconds from time the token is issued. |  |
| **token_type** | **String** | Token type. The value is always &#x60;Bearer&#x60;. | [default to &#39;Bearer&#39;] |

## Example

```ruby
require 'line_client_channel_access_token'

instance = LINE::Client::ChannelAccessToken::IssueShortLivedChannelAccessTokenResponse.new(
  access_token: null,
  expires_in: null,
  token_type: null
)
```

