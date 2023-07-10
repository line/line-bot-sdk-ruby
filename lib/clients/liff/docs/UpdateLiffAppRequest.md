# LINE::Client::Liff::UpdateLiffAppRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **view** | [**LiffView**](LiffView.md) |  | [optional] |
| **description** | **String** | Name of the LIFF app.  The LIFF app name can&#39;t include \&quot;LINE\&quot; or similar strings, or inappropriate strings.  | [optional] |
| **features** | [**LiffFeatures**](LiffFeatures.md) |  | [optional] |
| **permanent_link_pattern** | **String** | How additional information in LIFF URLs is handled. Specify &#x60;concat&#x60;.  | [optional] |
| **scope** | [**Array&lt;LiffScope&gt;**](LiffScope.md) |  | [optional] |
| **bot_prompt** | [**LiffBotPrompt**](LiffBotPrompt.md) |  | [optional] |

## Example

```ruby
require 'line_client_liff'

instance = LINE::Client::Liff::UpdateLiffAppRequest.new(
  view: null,
  description: null,
  features: null,
  permanent_link_pattern: null,
  scope: null,
  bot_prompt: null
)
```

