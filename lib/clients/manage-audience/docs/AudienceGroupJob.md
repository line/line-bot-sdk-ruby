# LINE::Client::ManageAudience::AudienceGroupJob

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_job_id** | **Integer** | A job ID. | [optional] |
| **audience_group_id** | **Integer** | An audience ID. | [optional] |
| **description** | **String** | The job&#39;s description. | [optional] |
| **type** | [**AudienceGroupJobType**](AudienceGroupJobType.md) |  | [optional] |
| **job_status** | [**AudienceGroupJobStatus**](AudienceGroupJobStatus.md) |  | [optional] |
| **failed_type** | [**AudienceGroupJobFailedType**](AudienceGroupJobFailedType.md) |  | [optional] |
| **audience_count** | **Integer** | The number of accounts (recipients) that were added or removed. | [optional] |
| **created** | **Integer** | When the job was created (in UNIX time). | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::AudienceGroupJob.new(
  audience_group_job_id: null,
  audience_group_id: null,
  description: null,
  type: null,
  job_status: null,
  failed_type: null,
  audience_count: null,
  created: null
)
```

