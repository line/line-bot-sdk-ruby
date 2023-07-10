# LINE::Client::MessagingApi::RichMenuBulkUnlinkRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_ids** | **Array&lt;String&gt;** | Array of user IDs. Found in the &#x60;source&#x60; object of webhook event objects. Do not use the LINE ID used in LINE. |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::RichMenuBulkUnlinkRequest.new(
  user_ids: null
)
```

