# LINE::Client::MessagingApi::UserProfileResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **display_name** | **String** | User&#39;s display name |  |
| **user_id** | **String** | User ID |  |
| **picture_url** | **String** | Profile image URL. &#x60;https&#x60; image URL. Not included in the response if the user doesn&#39;t have a profile image. | [optional] |
| **status_message** | **String** | User&#39;s status message. Not included in the response if the user doesn&#39;t have a status message. | [optional] |
| **language** | **String** | User&#39;s language, as a BCP 47 language tag. Not included in the response if the user hasn&#39;t yet consented to the LINE Privacy Policy. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::UserProfileResponse.new(
  display_name: null,
  user_id: null,
  picture_url: null,
  status_message: null,
  language: en
)
```

