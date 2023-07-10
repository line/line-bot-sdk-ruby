# LINE::Client::MessagingApi::RichMenuBatchProgressResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **phase** | [**RichMenuBatchProgressPhase**](RichMenuBatchProgressPhase.md) |  |  |
| **accepted_time** | **Time** | The accepted time in milliseconds of the request of batch control the rich menu.  Format: ISO 8601 (e.g. 2023-06-08T10:15:30.121Z) Timezone: UTC  |  |
| **completed_time** | **Time** | The completed time in milliseconds of rich menu batch control. Returned when the phase property is succeeded or failed.  Format: ISO 8601 (e.g. 2023-06-08T10:15:30.121Z) Timezone: UTC  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::RichMenuBatchProgressResponse.new(
  phase: null,
  accepted_time: null,
  completed_time: null
)
```

