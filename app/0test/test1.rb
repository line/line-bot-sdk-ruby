# require 'rest-client'
require 'json'
# require 'sinatra'   # gem 'sinatra'
# require 'line/bot'  # gem 'line-bot-api'
require 'sinatra'
require 'line/bot'

def search_businesses_from_yelp(times)
  token = ENV['YELP_API_KEY']
  yelp_ep = 'https://api.yelp.com/v3/businesses/search'
  params = { 
      latitude: 36.108722,
      longitude: 140.103961, #筑波大学
      radius: 8000,
      limit: 50,
      open_now: true,
      price: 1
  } 

  response = RestClient.get yelp_ep, { :Authorization => "bearer #{token}", params: params }
  response_json = JSON.parse(response)
  response_json['businesses'].sample(times <= 10 ? times : 10) #最大10件
end

def get_random_meshi(num)
  results = []
  businesses = search_businesses_from_yelp(num)

  businesses.each do |business|
    results.push(
      {
        "thumbnailImageUrl": business['image_url'],
        "imageBackgroundColor": "#FFFFFF",
        "title": business['id'],
        "text": "評価 #{business['rating']}",
        "actions": [
            {
                "type": "uri",
                "label": "詳細をみる",
                "uri": business['url']
            }
        ]
      }
    )  
  end

  {
   "type": "template",
   "altText": "ガチャ結果",
   "template": {
      "type": "carousel",
      "columns": results,
      "imageAspectRatio": "rectangle",
      "imageSize": "cover"
    }
  } 
end

# require_relative 'meshi'

def get_gacha_reply(word)
  times = 1
  case word.tr("０-９", "0-9")
    when /(\d+)連/ then
      times = $1.to_i
  end

  case word
    when /(飯|めし|メシ)/ then
      get_random_meshi(times)
  end
end

# require_relative 'gacha'

def get_bot_response_message(word)
  case word
  when /ガチャ/ then
    get_gacha_reply(word)
  when /(ping|生きてる？)/ then
    {
      type: 'text',
      text: '生きとるで〜'
    } 
  end
end

# require 'sinatra'   # gem 'sinatra'
# require 'line/bot'  # gem 'line-bot-api'
# require_relative 'lib/interactor'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)

  events.each { |event|
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        if event.message['text'] == '天気'
          client.reply_message(event['replyToken'], message = {
            type: 'text',
            text: "終了しました"
          })
        else
        message = get_bot_response_message(event.message['text'])
        client.reply_message(event['replyToken'], message)
        end
      end
    end
  }

  "OK"
end

# require 'sinatra'
# require 'line/bot'

# def client
#   @client ||= Line::Bot::Client.new { |config|
#     config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
#     config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
#   }
# end

# num = 0

# post '/callback' do
#   body = request.body.read

#   signature = request.env['HTTP_X_LINE_SIGNATURE']
#   unless client.validate_signature(body, signature)
#     error 400 do 'Bad Request' end
#   end

#   events = client.parse_events_from(body)

#   events.each { |event|
#     case event
#     when Line::Bot::Event::Message
#       case event.type
#       when Line::Bot::Event::MessageType::Text
#         # メッセージのおうむ返し
#         message = {
#           type: 'text',
#           # text: event.message['text'] + num
#           text: "テスト#{num.to_s}回目"
#         }
#         # 必ずおはようを返す。
#         # message = {
#         #   type: 'text',
#         #   text: 'おはよう'
#         # }
#         client.reply_message(event['replyToken'], message)
#       when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
#         response = client.get_message_content(event.message['id'])
#         tf = Tempfile.open("content")
#         tf.write(response.body)
#       end
#     end
#   }

#   "OK"
# end