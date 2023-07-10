# LINE::Client::ManageAudience::CreateImpBasedAudienceGroupResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. | [optional] |
| **type** | [**AudienceGroupType**](AudienceGroupType.md) |  | [optional] |
| **description** | **String** | The audience&#39;s name. | [optional] |
| **created** | **Integer** | When the audience was created (in UNIX time). | [optional] |
| **request_id** | **String** | The request ID that was specified when the audience was created. | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::CreateImpBasedAudienceGroupResponse.new(
  audience_group_id: null,
  type: null,
  description: null,
  created: null,
  request_id: null
)
```

