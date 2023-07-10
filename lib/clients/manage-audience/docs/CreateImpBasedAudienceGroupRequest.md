# LINE::Client::ManageAudience::CreateImpBasedAudienceGroupRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **description** | **String** | The audience&#39;s name. This is case-insensitive, meaning &#x60;AUDIENCE&#x60; and &#x60;audience&#x60; are considered identical. Max character limit: 120  | [optional] |
| **request_id** | **String** | The request ID of a broadcast or narrowcast message sent in the past 60 days. Each Messaging API request has a request ID.  | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::CreateImpBasedAudienceGroupRequest.new(
  description: null,
  request_id: null
)
```

