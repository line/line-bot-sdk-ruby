# LINE::Client::MessagingApi::RichMenuRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **size** | [**RichMenuSize**](RichMenuSize.md) |  | [optional] |
| **selected** | **Boolean** | &#x60;true&#x60; to display the rich menu by default. Otherwise, &#x60;false&#x60;. | [optional] |
| **name** | **String** | Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users. | [optional] |
| **chat_bar_text** | **String** | Text displayed in the chat bar | [optional] |
| **areas** | [**Array&lt;RichMenuArea&gt;**](RichMenuArea.md) | Array of area objects which define the coordinates and size of tappable areas | [optional] |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::RichMenuRequest.new(
  size: null,
  selected: null,
  name: null,
  chat_bar_text: null,
  areas: null
)
```

