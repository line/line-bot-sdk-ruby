require 'line/bot'

def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
end

def main
  # 2. Create rich menu A (richmenu-a)
  create_rich_menu_response = client.create_rich_menu(rich_menu_object_a)
  rich_a_menu = JSON.parse(create_rich_menu_response.body)
  puts "created: #{rich_a_menu}"
  # => {"richMenuId"=>"richmenu-xxx"}
  # 3. Upload image to rich menu A
  client.create_rich_menu_image(rich_a_menu['richMenuId'], File.open('./public/richmenu-a.png'))
  # 4. Create rich menu B (richmenu-b)
  create_rich_menu_response = client.create_rich_menu(rich_menu_object_b)
  rich_b_menu = JSON.parse(create_rich_menu_response.body)
  puts "created: #{rich_b_menu}"
  # => {"richMenuId"=>"richmenu-xxx"}
  # 5. Upload image to rich menu B
  client.create_rich_menu_image(rich_b_menu['richMenuId'], File.open('./public/richmenu-b.png'))
  # 6. Set rich menu A as the default rich menu
  client.set_default_rich_menu(rich_a_menu['richMenuId'])
  # 7. Create rich menu alias A
  client.set_rich_menus_alias(rich_a_menu['richMenuId'], 'richmenu-alias-a')
  # 8. Create rich menu alias B
  client.set_rich_menus_alias(rich_b_menu['richMenuId'], 'richmenu-alias-b')
  puts 'success'
end

def rich_menu_object_a
  {
    "size": {
      "width": 2500,
      "height": 1686
    },
    "selected": false,
    "name": "richmenu-a",
    "chatBarText": "Tap to open",
    "areas": [
      {
        "bounds": {
          "x": 0,
          "y": 0,
          "width": 1250,
          "height": 1686
        },
        "action": {
          "type": "uri",
          "uri": "https://www.line-community.me/"
        }
      },
      {
        "bounds": {
          "x": 1251,
          "y": 0,
          "width": 1250,
          "height": 1686
        },
        "action": {
          "type": "richmenuswitch",
          "richMenuAliasId": "richmenu-alias-b",
          "data": "richmenu-changed-to-b"
        }
      }
    ]
  }
end

def rich_menu_object_b
  {
    "size": {
      "width": 2500,
      "height": 1686
    },
    "selected": false,
    "name": "richmenu-a",
    "chatBarText": "Tap to open",
    "areas": [
      {
        "bounds": {
          "x": 0,
          "y": 0,
          "width": 1250,
          "height": 1686
        },
        "action": {
          "type": "richmenuswitch",
          "richMenuAliasId": "richmenu-alias-a",
          "data": "richmenu-changed-to-a"
        }
      },
      {
        "bounds": {
          "x": 1251,
          "y": 0,
          "width": 1250,
          "height": 1686
        },
        "action": {
          "type": "uri",
          "uri": "https://www.line-community.me/"
        }
      }
    ]
  }
end

main
