# LINE::Client::ManageAudience::CreateClickBasedAudienceGroupRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **description** | **String** | The audience&#39;s name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120  | [optional] |
| **request_id** | **String** | The request ID of a broadcast or narrowcast message sent in the past 60 days. Each Messaging API request has a request ID.  | [optional] |
| **click_url** | **String** | The URL clicked by the user. If empty, users who clicked any URL in the message are added to the list of recipients. Max character limit: 2,000  | [optional] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::CreateClickBasedAudienceGroupRequest.new(
  description: null,
  request_id: null,
  click_url: null
)
```

