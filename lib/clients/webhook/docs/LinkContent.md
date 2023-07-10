# LINE::Client::Webhook::LinkContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **result** | **String** | One of the following values to indicate whether linking the account was successful or not |  |
| **nonce** | **String** | Specified nonce (number used once) when verifying the user ID. |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::LinkContent.new(
  result: null,
  nonce: null
)
```

