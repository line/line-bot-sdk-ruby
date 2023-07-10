# LINE::Client::ManageAudience::GetAudienceDataResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group** | [**AudienceGroup**](AudienceGroup.md) |  | [optional] |
| **jobs** | [**Array&lt;AudienceGroupJob&gt;**](AudienceGroupJob.md) | An array of jobs. This array is used to keep track of each attempt to add new user IDs or IFAs to an audience for uploading user IDs. Empty array is returned for any other type of audience. Max: 50  | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::GetAudienceDataResponse.new(
  audience_group: null,
  jobs: null
)
```

