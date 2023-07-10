# LINE::Client::ManageAudience::CreateAudienceGroupRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **description** | **String** | The audience&#39;s name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120  | [optional] |
| **is_ifa_audience** | **Boolean** | To specify recipients by IFAs: set true. To specify recipients by user IDs: set false or omit isIfaAudience property.  | [optional] |
| **upload_description** | **String** | The description to register for the job (in jobs[].description).  | [optional] |
| **audiences** | [**Array&lt;Audience&gt;**](Audience.md) | An array of user IDs or IFAs. Max number: 10,000  | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::CreateAudienceGroupRequest.new(
  description: null,
  is_ifa_audience: null,
  upload_description: null,
  audiences: null
)
```

