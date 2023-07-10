# LINE::Client::MessagingApi::GroupSummaryResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID |  |
| **group_name** | **String** | Group name |  |
| **picture_url** | **String** | Group icon URL. Not included in the response if the user doesn&#39;t set a group profile icon. | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::GroupSummaryResponse.new(
  group_id: null,
  group_name: null,
  picture_url: null
)
```

