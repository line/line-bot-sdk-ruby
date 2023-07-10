# LINE::Client::MessagingApi::Limit

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **max** | **Integer** | The maximum number of narrowcast messages to send. Use this parameter to limit the number of narrowcast messages sent. The recipients will be chosen at random.  | [optional] |
| **up_to_remaining_quota** | **Boolean** | If true, the message will be sent within the maximum number of deliverable messages. The default value is &#x60;false&#x60;.  Targets will be selected at random.  | [optional][default to false] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::Limit.new(
  max: null,
  up_to_remaining_quota: null
)
```

