# LINE::Client::Webhook::CallbackRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **destination** | **String** | User ID of a bot that should receive webhook events. The user ID value is a string that matches the regular expression, &#x60;U[0-9a-f]{32}&#x60;.  | [optional] |
| **events** | [**Array&lt;Event&gt;**](Event.md) | Array of webhook event objects. The LINE Platform may send an empty array that doesn&#39;t include a webhook event object to confirm communication.  | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::CallbackRequest.new(
  destination: null,
  events: null
)
```

