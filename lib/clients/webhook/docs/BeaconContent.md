# LINE::Client::Webhook::BeaconContent

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **hwid** | **String** | Hardware ID of the beacon that was detected |  |
| **type** | **String** | Type of beacon event. |  |
| **dm** | **String** | Device message of beacon that was detected. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::BeaconContent.new(
  hwid: null,
  type: null,
  dm: null
)
```

