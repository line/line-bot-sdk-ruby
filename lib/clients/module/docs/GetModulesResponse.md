# LINE::Client::Module::GetModulesResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **bots** | [**Array&lt;ModuleBot&gt;**](ModuleBot.md) | Array of Bot list Item objects representing basic information about the bot. |  |
| **_next** | **String** | Continuation token. Used to get the next array of basic bot information. This property is only returned if there are more unreturned results.  | [optional] |

## Example

```ruby
require 'line_client_module'

instance = LINE::Client::Module::GetModulesResponse.new(
  bots: null,
  _next: null
)
```

