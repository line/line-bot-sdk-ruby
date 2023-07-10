# LINE::Client::MessagingApi::GetMessageContentTranscodingResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | **String** | The preparation status. One of:  &#x60;processing&#x60;: Preparing to get content. &#x60;succeeded&#x60;: Ready to get the content. You can get the content sent by users. &#x60;failed&#x60;: Failed to prepare to get the content.  |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::GetMessageContentTranscodingResponse.new(
  status: null
)
```

