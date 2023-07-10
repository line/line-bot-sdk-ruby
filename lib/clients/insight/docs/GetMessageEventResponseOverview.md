# LINE::Client::Insight::GetMessageEventResponseOverview

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **request_id** | **String** | Request ID. | [optional] |
| **timestamp** | **Integer** | UNIX timestamp for message delivery time in seconds. | [optional] |
| **delivered** | **Integer** | Number of messages delivered. This property shows values of less than 20. However, if all messages have not been sent, it will be null.  | [optional] |
| **unique_impression** | **Integer** | Number of users who opened the message, meaning they displayed at least 1 bubble. | [optional] |
| **unique_click** | **Integer** | Number of users who opened any URL in the message. | [optional] |
| **unique_media_played** | **Integer** | Number of users who started playing any video or audio in the message. | [optional] |
| **unique_media_played100_percent** | **Integer** | Number of users who played the entirety of any video or audio in the message. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetMessageEventResponseOverview.new(
  request_id: null,
  timestamp: null,
  delivered: null,
  unique_impression: null,
  unique_click: null,
  unique_media_played: null,
  unique_media_played100_percent: null
)
```

