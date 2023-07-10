# LINE::Client::Module::ModuleBot

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | Bot&#39;s user ID |  |
| **basic_id** | **String** | Bot&#39;s basic ID |  |
| **premium_id** | **String** | Bot&#39;s premium ID. Not included in the response if the premium ID isn&#39;t set. | [optional] |
| **display_name** | **String** | Bot&#39;s display name |  |
| **picture_url** | **String** | Profile image URL. Image URL starting with &#x60;https://&#x60;. Not included in the response if the bot doesn&#39;t have a profile image. | [optional] |

## Example

```ruby
require 'line_client_module'

instance = LINE::Client::Module::ModuleBot.new(
  user_id: null,
  basic_id: null,
  premium_id: null,
  display_name: null,
  picture_url: null
)
```

