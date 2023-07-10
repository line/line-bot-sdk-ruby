# LINE::Client::Insight::GetStatisticsPerUnitResponseClick

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **seq** | **Integer** | The URL&#39;s serial number. |  |
| **url** | **String** | URL. |  |
| **click** | **Integer** | Number of times the URL in the bubble was opened. | [optional] |
| **unique_click** | **Integer** | Number of users that opened the URL in the bubble. | [optional] |
| **unique_click_of_request** | **Integer** | Number of users who opened this url through any link in the message. If another message bubble contains the same URL and a user opens both links, it&#39;s counted only once.  | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetStatisticsPerUnitResponseClick.new(
  seq: null,
  url: null,
  click: null,
  unique_click: null,
  unique_click_of_request: null
)
```

