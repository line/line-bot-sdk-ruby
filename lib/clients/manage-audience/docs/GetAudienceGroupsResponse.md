# LINE::Client::ManageAudience::GetAudienceGroupsResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_groups** | [**Array&lt;AudienceGroup&gt;**](AudienceGroup.md) | An array of audience data. If there are no audiences that match the specified filter, an empty array will be returned. | [optional] |
| **has_next_page** | **Boolean** | true when this is not the last page. | [optional] |
| **total_count** | **Integer** | The total number of audiences that can be returned with the specified filter. | [optional] |
| **read_write_audience_group_total_count** | **Integer** | Of the audiences you can get with the specified filter, the number of audiences with the update permission set to READ_WRITE. | [optional] |
| **page** | **Integer** | The current page number. | [optional] |
| **size** | **Integer** | The maximum number of audiences on the current page. | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::GetAudienceGroupsResponse.new(
  audience_groups: null,
  has_next_page: null,
  total_count: null,
  read_write_audience_group_total_count: null,
  page: null,
  size: null
)
```

