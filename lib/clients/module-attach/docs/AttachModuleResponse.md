# LINE::Client::ModuleAttach::AttachModuleResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **bot_id** | **String** | User ID of the bot on the LINE Official Account. |  |
| **scopes** | **Array&lt;String&gt;** | Permissions (scope) granted by the LINE Official Account admin. |  |

## Example

```ruby
require 'line_client_module_attach'

instance = LINE::Client::ModuleAttach::AttachModuleResponse.new(
  bot_id: null,
  scopes: null
)
```

