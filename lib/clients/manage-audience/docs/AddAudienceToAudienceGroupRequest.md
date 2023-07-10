# LINE::Client::ManageAudience::AddAudienceToAudienceGroupRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. | [optional] |
| **upload_description** | **String** | The audience&#39;s name. | [optional] |
| **audiences** | [**Array&lt;Audience&gt;**](Audience.md) | An array of up to 10,000 user IDs or IFAs. | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::AddAudienceToAudienceGroupRequest.new(
  audience_group_id: null,
  upload_description: null,
  audiences: null
)
```

