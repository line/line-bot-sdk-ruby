require 'sinatra'
require 'line/bot'

# 微小変更部分！確認用。
get '/' do
  "Hello world"
end

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

# require './app/return'
# require './app/0test'
menu_index = "オウム返し"

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
#         if event.message['text'] == '天気'
#           require './app/weather'
#           say_weather = Say_weather.new
#           message = say_weather.message
#           client.reply_message(event['replyToken'], message)
#           # client.reply_message(event['replyToken'], message = {
#           #   type: 'text',
#           #   text: "終了しました"
#           # })
#         elsif event.message['text'] == 'オウム返し'
#           menu_index = "オウム返し"
#           # require './app/return'
#           # client.reply_message(event['replyToken'],   message = {
#           #   type: 'text',
#           #   text: "オウムだよ"
#           # })
#           # loop{
#           #   if event.message['text'] == 'また明日' then
#           #     break
#           #   else
#           #     message = {
#           #       type: 'text',
#           #       text: event.message['text']
#           #     }
#           #     client.reply_message(event['replyToken'], message)
#           #   end
#           # }
#         else
#           message = {
#             type: 'text',
#             text: "「天気」か「オウム返し」\nとメッセージを送信して下さい。"
#           }
#           client.reply_message(event['replyToken'], message)
#         end
#       # when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
#       #   response = client.get_message_content(event.message['id'])
#       #   tf = Tempfile.open("content")
#       #   tf.write(response.body)!
#       else
#         message = {
#           type: 'text',
#           text: "メッセージで「天気」か「オウム返し」\nとメッセージを送信して下さい。"
#         }
#         client.reply_message(event['replyToken'], message)
#       end
#     end
#     # message = {
#     #   type: 'text',
#     #   text: "終わり"
#     # }
#     # client.reply_message(event['replyToken'], message)

#   }

#   "OK"
# end

if menu_index == "オウム返し"
  require './app/return'
  # require './app/0test'
end