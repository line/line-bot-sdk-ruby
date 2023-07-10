# LINE::Client::Webhook::LocationMessageContentAllOf

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Message ID |  |
| **title** | **String** | Title | [optional] |
| **address** | **String** | Address | [optional] |
| **latitude** | **Float** | Latitude |  |
| **longitude** | **Float** | Longitude |  |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::LocationMessageContentAllOf.new(
  id: null,
  title: null,
  address: null,
  latitude: null,
  longitude: null
)
```

