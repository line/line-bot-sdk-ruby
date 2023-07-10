# LINE::Client::Liff::LiffFeatures

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **ble** | **Boolean** | &#x60;true&#x60; if the LIFF app supports Bluetooth® Low Energy for LINE Things. &#x60;false&#x60; otherwise.  | [optional] |
| **qr_code** | **Boolean** | &#x60;true&#x60; to use the 2D code reader in the LIFF app. false otherwise. The default value is &#x60;false&#x60;.  | [optional][default to false] |

## Example

```ruby
require 'line_client_liff'

instance = LINE::Client::Liff::LiffFeatures.new(
  ble: null,
  qr_code: null
)
```

