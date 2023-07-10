# LINE::Client::MessagingApi::GroupUserProfileResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **display_name** | **String** | User&#39;s display name |  |
| **user_id** | **String** | User ID |  |
| **picture_url** | **String** | Profile image URL. &#x60;https&#x60; image URL. Not included in the response if the user doesn&#39;t have a profile image. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::GroupUserProfileResponse.new(
  display_name: null,
  user_id: null,
  picture_url: null
)
```

