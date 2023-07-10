# LINE::Client::MessagingApi::BotInfoResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Bot&#39;s user ID |  |
| **basic_id** | **String** | Bot&#39;s basic ID |  |
| **premium_id** | **String** | Bot&#39;s premium ID. Not included in the response if the premium ID isn&#39;t set. | [optional] |
| **display_name** | **String** | Bot&#39;s display name |  |
| **picture_url** | **String** | Profile image URL. &#x60;https&#x60; image URL. Not included in the response if the bot doesn&#39;t have a profile image. | [optional] |
| **chat_mode** | **String** | Chat settings set in the LINE Official Account Manager. One of:  &#x60;chat&#x60;: Chat is set to \&quot;On\&quot;. &#x60;bot&#x60;: Chat is set to \&quot;Off\&quot;.  |  |
| **mark_as_read_mode** | **String** | Automatic read setting for messages. If the chat is set to \&quot;Off\&quot;, auto is returned. If the chat is set to \&quot;On\&quot;, manual is returned.  &#x60;auto&#x60;: Auto read setting is enabled. &#x60;manual&#x60;: Auto read setting is disabled.   |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::BotInfoResponse.new(
  user_id: null,
  basic_id: null,
  premium_id: null,
  display_name: null,
  picture_url: null,
  chat_mode: null,
  mark_as_read_mode: null
)
```

