# LINE::Client::MessagingApi::RichMenuBatchRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **operations** | [**Array&lt;RichMenuBatchOperation&gt;**](RichMenuBatchOperation.md) | Array of Rich menu operation object... |  |
| **resume_request_key** | **String** | Key for retry. Key value is a string matching the regular expression pattern | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::RichMenuBatchRequest.new(
  operations: null,
  resume_request_key: null
)
```

