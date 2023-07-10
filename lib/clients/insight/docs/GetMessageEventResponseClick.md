# LINE::Client::Insight::GetMessageEventResponseClick

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **seq** | **Integer** | The URL&#39;s serial number. | [optional] |
| **url** | **String** | URL. | [optional] |
| **click** | **Integer** | Number of times the URL was opened. | [optional] |
| **unique_click** | **Integer** | Number of users that opened the URL. | [optional] |
| **unique_click_of_request** | **Integer** | Number of users who opened this url through any link in the message. If a message contains two links to the same URL and a user opens both links, they&#39;re counted only once. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetMessageEventResponseClick.new(
  seq: null,
  url: null,
  click: null,
  unique_click: null,
  unique_click_of_request: null
)
```

