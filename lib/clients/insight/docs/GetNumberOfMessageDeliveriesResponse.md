# LINE::Client::Insight::GetNumberOfMessageDeliveriesResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | **String** | Status of the counting process. | [optional] |
| **broadcast** | **Integer** | Number of messages sent to all of this LINE Official Account&#39;s friends (broadcast messages). | [optional] |
| **targeting** | **Integer** | Number of messages sent to some of this LINE Official Account&#39;s friends, based on specific attributes (targeted messages). | [optional] |
| **auto_response** | **Integer** | Number of auto-response messages sent. | [optional] |
| **welcome_response** | **Integer** | Number of greeting messages sent. | [optional] |
| **chat** | **Integer** | Number of messages sent from LINE Official Account Manager [Chat screen](https://www.linebiz.com/jp/manual/OfficialAccountManager/chats/) (only available in Japanese). | [optional] |
| **api_broadcast** | **Integer** | Number of broadcast messages sent with the &#x60;Send broadcast message&#x60; Messaging API operation. | [optional] |
| **api_push** | **Integer** | Number of push messages sent with the &#x60;Send push message&#x60; Messaging API operation. | [optional] |
| **api_multicast** | **Integer** | Number of multicast messages sent with the &#x60;Send multicast message&#x60; Messaging API operation. | [optional] |
| **api_narrowcast** | **Integer** | Number of narrowcast messages sent with the &#x60;Send narrowcast message&#x60; Messaging API operation. | [optional] |
| **api_reply** | **Integer** | Number of replies sent with the &#x60;Send reply message&#x60; Messaging API operation. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetNumberOfMessageDeliveriesResponse.new(
  status: null,
  broadcast: null,
  targeting: null,
  auto_response: null,
  welcome_response: null,
  chat: null,
  api_broadcast: null,
  api_push: null,
  api_multicast: null,
  api_narrowcast: null,
  api_reply: null
)
```

