# LINE::Client::Webhook::AccountLinkEventAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_token** | **String** | Reply token used to send reply message to this event. This property won&#39;t be included if linking the account has failed. | [optional] |
| **link** | [**LinkContent**](LinkContent.md) |  |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::AccountLinkEventAllOf.new(
  reply_token: null,
  link: null
)
```

