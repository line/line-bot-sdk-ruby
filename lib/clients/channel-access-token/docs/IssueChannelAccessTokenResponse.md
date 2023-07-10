# LINE::Client::ChannelAccessToken::IssueChannelAccessTokenResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | Channel access token.  |  |
| **expires_in** | **Integer** | Amount of time in seconds from issue to expiration of the channel access token |  |
| **token_type** | **String** | A token type. | [default to &#39;Bearer&#39;] |
| **key_id** | **String** | Unique key ID for identifying the channel access token. |  |

## Example

```ruby
require 'line_client_channel_access_token'

instance = LINE::Client::ChannelAccessToken::IssueChannelAccessTokenResponse.new(
  access_token: null,
  expires_in: null,
  token_type: null,
  key_id: null
)
```

