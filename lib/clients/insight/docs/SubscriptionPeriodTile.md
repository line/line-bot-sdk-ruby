# LINE::Client::Insight::SubscriptionPeriodTile

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **subscription_period** | **String** | Subscription period. Possible values: &#x60;within7days&#x60;, &#x60;within90days&#x60;, &#x60;unknown&#x60; etc. | [optional] |
| **percentage** | **Float** | Percentage. Possible values: [0.0,100.0] e.g. 0, 2.9, 37.6. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::SubscriptionPeriodTile.new(
  subscription_period: null,
  percentage: null
)
```

