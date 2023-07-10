# LINE::Client::Webhook::ScenarioResult

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **scenario_id** | **String** | Scenario ID executed | [optional] |
| **revision** | **Integer** | Revision number of the scenario set containing the executed scenario | [optional] |
| **start_time** | **Integer** | Timestamp for when execution of scenario action started (milliseconds, LINE app time) |  |
| **end_time** | **Integer** | Timestamp for when execution of scenario was completed (milliseconds, LINE app time) |  |
| **result_code** | **String** | Scenario execution completion status |  |
| **action_results** | [**Array&lt;ActionResult&gt;**](ActionResult.md) | Execution result of individual operations specified in action. Only included when things.result.resultCode is success. | [optional] |
| **ble_notification_payload** | **String** | Data contained in notification. | [optional] |
| **error_reason** | **String** | Error reason. | [optional] |

## Example

```ruby
require 'line_client_webhook'

instance = LINE::Client::Webhook::ScenarioResult.new(
  scenario_id: null,
  revision: null,
  start_time: null,
  end_time: null,
  result_code: null,
  action_results: null,
  ble_notification_payload: null,
  error_reason: null
)
```

