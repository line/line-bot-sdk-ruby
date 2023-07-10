# LINE::Client::Insight::GetStatisticsPerUnitResponseOverview

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **unique_impression** | **Integer** | Number of users who opened the message, meaning they displayed at least 1 bubble. | [optional] |
| **unique_click** | **Integer** | Number of users who opened any URL in the message. | [optional] |
| **unique_media_played** | **Integer** | Number of users who started playing any video or audio in the message. | [optional] |
| **unique_media_played100_percent** | **Integer** | Number of users who played the entirety of any video or audio in the message. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetStatisticsPerUnitResponseOverview.new(
  unique_impression: null,
  unique_click: null,
  unique_media_played: null,
  unique_media_played100_percent: null
)
```

