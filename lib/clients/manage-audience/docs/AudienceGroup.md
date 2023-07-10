# LINE::Client::ManageAudience::AudienceGroup

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. | [optional] |
| **type** | [**AudienceGroupType**](AudienceGroupType.md) |  | [optional] |
| **description** | **String** | The audience&#39;s name. | [optional] |
| **status** | [**AudienceGroupStatus**](AudienceGroupStatus.md) |  | [optional] |
| **failed_type** | [**AudienceGroupFailedType**](AudienceGroupFailedType.md) |  | [optional] |
| **audience_count** | **Integer** | The number of users included in the audience. | [optional] |
| **created** | **Integer** | When the audience was created (in UNIX time). | [optional] |
| **request_id** | **String** | The request ID that was specified when the audience was created. This is only included when &#x60;audienceGroup.type&#x60; is CLICK or IMP.  | [optional] |
| **click_url** | **String** | The URL that was specified when the audience was created. This is only included when &#x60;audienceGroup.type&#x60; is CLICK and link URL is specified.  | [optional] |
| **is_ifa_audience** | **Boolean** | The value indicating the type of account to be sent, as specified when creating the audience for uploading user IDs.  | [optional] |
| **permission** | [**AudienceGroupPermission**](AudienceGroupPermission.md) |  | [optional] |
| **create_route** | [**AudienceGroupCreateRoute**](AudienceGroupCreateRoute.md) |  | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::AudienceGroup.new(
  audience_group_id: null,
  type: null,
  description: null,
  status: null,
  failed_type: null,
  audience_count: null,
  created: null,
  request_id: null,
  click_url: null,
  is_ifa_audience: null,
  permission: null,
  create_route: null
)
```

