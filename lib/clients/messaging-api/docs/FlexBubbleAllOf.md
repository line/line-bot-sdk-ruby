# LINE::Client::MessagingApi::FlexBubbleAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **direction** | **String** |  | [optional] |
| **styles** | [**FlexBubbleStyles**](FlexBubbleStyles.md) |  | [optional] |
| **header** | [**FlexBox**](FlexBox.md) |  | [optional] |
| **hero** | [**FlexComponent**](FlexComponent.md) |  | [optional] |
| **body** | [**FlexBox**](FlexBox.md) |  | [optional] |
| **footer** | [**FlexBox**](FlexBox.md) |  | [optional] |
| **size** | **String** |  | [optional] |
| **action** | [**Action**](Action.md) |  | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::FlexBubbleAllOf.new(
  direction: null,
  styles: null,
  header: null,
  hero: null,
  body: null,
  footer: null,
  size: null,
  action: null
)
```

