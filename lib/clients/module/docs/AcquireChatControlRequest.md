# LINE::Client::Module::AcquireChatControlRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **expired** | **Boolean** | &#x60;True&#x60;: After the time limit (ttl) has passed, the initiative (Chat Control) will return to the Primary Channel. (Default) &#x60;False&#x60;: There&#39;s no time limit and the initiative (Chat Control) doesn&#39;t change over time.  | [optional] |
| **ttl** | **Integer** | The time it takes for initiative (Chat Control) to return to the Primary Channel (the time that the module channel stays on the Active Channel). The value is specified in seconds. The maximum value is one year (3600 * 24 * 365). The default value is 3600 (1 hour).  * Ignored if the value of expired is false.  | [optional] |

## Example

```ruby
require 'line_client_module'

instance = LINE::Client::Module::AcquireChatControlRequest.new(
  expired: true,
  ttl: 3600
)
```

