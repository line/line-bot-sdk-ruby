# LINE::Client::Insight::GetNumberOfFollowersResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | **String** | Calculation status. | [optional] |
| **followers** | **Integer** | The number of times, as of the specified date, that a user added this LINE Official Account as a friend for the first time. The number doesn&#39;t decrease even if a user later blocks the account or when they delete their LINE account.  | [optional] |
| **targeted_reaches** | **Integer** | The number of users, as of the specified date, that the LINE Official Account can reach through targeted messages based on gender, age, and/or region. This number only includes users who are active on LINE or LINE services and whose demographics have a high level of certainty.  | [optional] |
| **blocks** | **Integer** | The number of users blocking the account as of the specified date. The number decreases when a user unblocks the account.    | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetNumberOfFollowersResponse.new(
  status: null,
  followers: null,
  targeted_reaches: null,
  blocks: null
)
```

