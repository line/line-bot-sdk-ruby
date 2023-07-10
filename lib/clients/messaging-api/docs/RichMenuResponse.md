# LINE::Client::MessagingApi::RichMenuResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | ID of a rich menu |  |
| **size** | [**RichMenuSize**](RichMenuSize.md) |  |  |
| **selected** | **Boolean** | &#x60;true&#x60; to display the rich menu by default. Otherwise, &#x60;false&#x60;. |  |
| **name** | **String** | Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users. |  |
| **chat_bar_text** | **String** | Text displayed in the chat bar |  |
| **areas** | [**Array&lt;RichMenuArea&gt;**](RichMenuArea.md) | Array of area objects which define the coordinates and size of tappable areas |  |

## Example

```ruby
require 'line_client_messaging_api'

instance = LINE::Client::MessagingApi::RichMenuResponse.new(
  rich_menu_id: null,
  size: null,
  selected: null,
  name: null,
  chat_bar_text: null,
  areas: null
)
```

