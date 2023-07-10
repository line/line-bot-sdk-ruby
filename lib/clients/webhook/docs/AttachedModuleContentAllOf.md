# LINE::Client::Webhook::AttachedModuleContentAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **bot_id** | **String** | User ID of the bot on the attached LINE Official Account |  |
| **scopes** | **Array&lt;String&gt;** | An array of strings indicating the scope permitted by the admin of the LINE Official Account. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::AttachedModuleContentAllOf.new(
  bot_id: null,
  scopes: null
)
```

