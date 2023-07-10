# LINE::Client::ChannelAccessToken::VerifyChannelAccessTokenResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **client_id** | **String** | The channel ID for which the channel access token was issued. |  |
| **expires_in** | **Integer** | Number of seconds before the channel access token expires. |  |
| **scope** | **String** | Permissions granted to the channel access token. | [optional] |

## Example

```ruby
require 'line_client_channel_access_token'

instance = LINE::Client::ChannelAccessToken::VerifyChannelAccessTokenResponse.new(
  client_id: null,
  expires_in: null,
  scope: null
)
```

