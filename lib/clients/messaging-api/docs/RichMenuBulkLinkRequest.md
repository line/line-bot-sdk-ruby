# LINE::Client::MessagingApi::RichMenuBulkLinkRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | ID of a rich menu |  |
| **user_ids** | **Array&lt;String&gt;** | Array of user IDs. Found in the &#x60;source&#x60; object of webhook event objects. Do not use the LINE ID used in LINE. |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::RichMenuBulkLinkRequest.new(
  rich_menu_id: null,
  user_ids: null
)
```

