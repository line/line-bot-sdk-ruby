# LINE::Client::MessagingApi::CreateRichMenuAliasRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_alias_id** | **String** | Rich menu alias ID, which can be any ID, unique for each channel. |  |
| **rich_menu_id** | **String** | The rich menu ID to be associated with the rich menu alias. |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::CreateRichMenuAliasRequest.new(
  rich_menu_alias_id: null,
  rich_menu_id: null
)
```

