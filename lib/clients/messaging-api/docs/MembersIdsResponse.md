# LINE::Client::MessagingApi::MembersIdsResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **member_ids** | **Array&lt;String&gt;** | List of user IDs of members in the group chat. Only users of LINE for iOS and LINE for Android are included in &#x60;memberIds&#x60;. |  |
| **_next** | **String** | A continuation token to get the next array of user IDs of the members in the group chat. Returned only when there are remaining user IDs that were not returned in &#x60;memberIds&#x60; in the original request.  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::MembersIdsResponse.new(
  member_ids: null,
  _next: null
)
```

