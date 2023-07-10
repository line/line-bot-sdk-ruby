# LINE::Client::Insight::GetFriendsDemographicsResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **available** | **Boolean** | true if friend demographic information is available. | [optional] |
| **genders** | [**Array&lt;GenderTile&gt;**](GenderTile.md) | Percentage per gender. | [optional] |
| **ages** | [**Array&lt;AgeTile&gt;**](AgeTile.md) | Percentage per age group. | [optional] |
| **areas** | [**Array&lt;AreaTile&gt;**](AreaTile.md) | Percentage per area. | [optional] |
| **app_types** | [**Array&lt;AppTypeTile&gt;**](AppTypeTile.md) | Percentage by OS. | [optional] |
| **subscription_periods** | [**Array&lt;SubscriptionPeriodTile&gt;**](SubscriptionPeriodTile.md) | Percentage per friendship duration. | [optional] |

## Example

```ruby
require 'line_client_insight'

instance = LINE::Client::Insight::GetFriendsDemographicsResponse.new(
  available: null,
  genders: null,
  ages: null,
  areas: null,
  app_types: null,
  subscription_periods: null
)
```

