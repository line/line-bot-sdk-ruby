# LINE::Client::Liff::LiffView

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Size of the LIFF app view. Specify one of these values: - compact - tall - full  |  |
| **url** | **String** | Endpoint URL. This is the URL of the web app that implements the LIFF app (e.g. https://example.com). Used when the LIFF app is launched using the LIFF URL. The URL scheme must be https. URL fragments (#URL-fragment) can&#39;t be specified.  |  |
| **module_mode** | **Boolean** | &#x60;true&#x60; to use the LIFF app in modular mode. When in modular mode, the action button in the header is not displayed.  | [optional] |

## Example

```ruby
require 'line_client_liff'

instance = LINE::Client::Liff::LiffView.new(
  type: null,
  url: null,
  module_mode: null
)
```

