# LINE::Client::Webhook::UserMentioneeAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | User ID of the mentioned user. Only included if mention.mentions[].type is user and the user consents to the LINE Official Account obtaining their user profile information. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::UserMentioneeAllOf.new(
  user_id: null
)
```

