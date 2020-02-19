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
# require './app/weather'

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
        # case event.message.text
        # when Line::Bot::Event::MessageType::Text::
        if event.message['text'] == '天気' then
          message = {
            type: 'text',
            text: "こんにちは\nと送信してください。"
          }
          client.reply_message(event['replyToken'], message)
          require './app/weather'
        elsif event.message['text'] == 'おうむ返し' then
          require './app/return'
        else
          message = {
            type: 'text',
            text: "「天気」か「おうむ返し」\nとメッセージを送信して下さい。"
          }
          client.reply_message(event['replyToken'], message)
        end
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end