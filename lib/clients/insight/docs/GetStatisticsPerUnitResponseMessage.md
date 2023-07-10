# LINE::Client::Insight::GetStatisticsPerUnitResponseMessage

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **seq** | **Integer** | Bubble&#39;s serial number. |  |
| **impression** | **Integer** | Number of times the bubble was displayed. | [optional] |
| **media_played** | **Integer** | Number of times audio or video in the bubble started playing. | [optional] |
| **media_played25_percent** | **Integer** | Number of times audio or video in the bubble started playing and was played 25% of the total time. | [optional] |
| **media_played50_percent** | **Integer** | Number of times audio or video in the bubble started playing and was played 50% of the total time. | [optional] |
| **media_played75_percent** | **Integer** | Number of times audio or video in the bubble started playing and was played 75% of the total time. | [optional] |
| **media_played100_percent** | **Integer** | Number of times audio or video in the bubble started playing and was played 100% of the total time. | [optional] |
| **unique_impression** | **Integer** | Number of users the bubble was displayed. | [optional] |
| **unique_media_played** | **Integer** | Number of users that started playing audio or video in the bubble. | [optional] |
| **unique_media_played25_percent** | **Integer** | Number of users that started playing audio or video in the bubble and played 25% of the total time. | [optional] |
| **unique_media_played50_percent** | **Integer** | Number of users that started playing audio or video in the bubble and played 50% of the total time. | [optional] |
| **unique_media_played75_percent** | **Integer** | Number of users that started playing audio or video in the bubble and played 75% of the total time. | [optional] |
| **unique_media_played100_percent** | **Integer** | Number of users that started playing audio or video in the bubble and played 100% of the total time. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetStatisticsPerUnitResponseMessage.new(
  seq: null,
  impression: null,
  media_played: null,
  media_played25_percent: null,
  media_played50_percent: null,
  media_played75_percent: null,
  media_played100_percent: null,
  unique_impression: null,
  unique_media_played: null,
  unique_media_played25_percent: null,
  unique_media_played50_percent: null,
  unique_media_played75_percent: null,
  unique_media_played100_percent: null
)
```

