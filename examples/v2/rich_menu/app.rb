require 'line/bot'

def client
  @client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def blob_client
  @blob_client ||= Line::Bot::V2::MessagingApi::ApiBlobClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def main
  create_rich_menu_a_response = client.create_rich_menu(rich_menu_request: rich_menu_request_a)
  puts "created: #{create_rich_menu_a_response.rich_menu_id}"
  blob_client.set_rich_menu_image(rich_menu_id: create_rich_menu_a_response.rich_menu_id, body: File.open('./public/richmenu-a.png'))

  create_rich_menu_b_response = client.create_rich_menu(rich_menu_request: rich_menu_request_b)
  puts "created: #{create_rich_menu_b_response.rich_menu_id}"
  blob_client.set_rich_menu_image(rich_menu_id: create_rich_menu_b_response.rich_menu_id, body: File.open('./public/richmenu-b.png'))

  client.set_default_rich_menu(rich_menu_id: create_rich_menu_a_response.rich_menu_id)

  client.create_rich_menu_alias(
    create_rich_menu_alias_request: Line::Bot::V2::MessagingApi::CreateRichMenuAliasRequest.new(
      rich_menu_id: create_rich_menu_a_response.rich_menu_id,
      rich_menu_alias_id: 'richmenu-alias-a'
    )
  )
  client.create_rich_menu_alias(
    create_rich_menu_alias_request: Line::Bot::V2::MessagingApi::CreateRichMenuAliasRequest.new(
      rich_menu_id: create_rich_menu_b_response.rich_menu_id,
      rich_menu_alias_id: 'richmenu-alias-b'
    )
  )
end

def rich_menu_request_a
  Line::Bot::V2::MessagingApi::RichMenuRequest.new(
    size: Line::Bot::V2::MessagingApi::RichMenuSize.new(width: 2500, height: 1686),
    selected: false,
    name: 'richmenu-a',
    chat_bar_text: 'Tap to open',
    areas: [
      Line::Bot::V2::MessagingApi::RichMenuArea.new(
        bounds: Line::Bot::V2::MessagingApi::RichMenuBounds.new(x: 0, y: 0, width: 1250, height: 1686),
        action: Line::Bot::V2::MessagingApi::URIAction.new(type: 'uri', uri: 'https://www.line-community.me/')
      ),
      Line::Bot::V2::MessagingApi::RichMenuArea.new(
        bounds: Line::Bot::V2::MessagingApi::RichMenuBounds.new(x: 1251, y: 0, width: 1250, height: 1686),
        action: Line::Bot::V2::MessagingApi::RichMenuSwitchAction.new(type: 'richmenuswitch', rich_menu_alias_id: 'richmenu-alias-b', data: 'richmenu-changed-to-b')
      )
    ]
  )
end

def rich_menu_request_b
  Line::Bot::V2::MessagingApi::RichMenuRequest.new(
    size: Line::Bot::V2::MessagingApi::RichMenuSize.new(width: 2500, height: 1686),
    selected: false,
    name: 'richmenu-b',
    chat_bar_text: 'Tap to open',
    areas: [
      Line::Bot::V2::MessagingApi::RichMenuArea.new(
        bounds: Line::Bot::V2::MessagingApi::RichMenuBounds.new(x: 0, y: 0, width: 1250, height: 1686),
        action: Line::Bot::V2::MessagingApi::RichMenuSwitchAction.new(type: 'richmenuswitch', rich_menu_alias_id: 'richmenu-alias-a', data: 'richmenu-changed-to-a')
      ),
      Line::Bot::V2::MessagingApi::RichMenuArea.new(
        bounds: Line::Bot::V2::MessagingApi::RichMenuBounds.new(x: 1251, y: 0, width: 1250, height: 1686),
        action: Line::Bot::V2::MessagingApi::URIAction.new(type: 'uri', uri: 'https://www.line-community.me/')
      )
    ]
  )
end

main
