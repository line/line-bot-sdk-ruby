require "./src/Weather"
require "./src/WeatherInfo"

# class Say_weather
#   def message
#     weatherobj = Weather.new
#     info = weatherobj.doProcess()
#     message = {
#       type: 'text',
#       text: "今日、#{info.today()} 東京の天気です。\n 天気    ：#{info.todayTelop()}\n 最高気温：#{info.todayTempMax()}\n 最低気温：#{info.todayTempMin()}\n\n明日、#{info.tmrw()} 東京の天気です。\n 天気    ：#{info.tmrwTelop()}\n 最高気温：#{info.tmrwTempMax()}\n 最低気温：#{info.tmrwTempMin()}\n【概要】\n #{info.description()}"
#     }
#   end
# end

# 下記は、app_menu.rb実装前のコード。メモ書きとして残しておく。
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
        if event.message['text'] == 'こんにちは' then
          message = {
            type: 'text',
            text: "今日、#{info.today()} 東京の天気です。\n 天気    ：#{info.todayTelop()}\n 最高気温：#{info.todayTempMax()}\n 最低気温：#{info.todayTempMin()}\n\n明日、#{info.tmrw()} 東京の天気です。\n 天気    ：#{info.tmrwTelop()}\n 最高気温：#{info.tmrwTempMax()}\n 最低気温：#{info.tmrwTempMin()}\n【概要】\n #{info.description()}"
          }
        else
          message = {
            type: 'text',
            text: "こんにちは\nと送信してください。"
          }
        end
        client.reply_message(event['replyToken'], message)
        #下記の書き方でも、返信メッセージを代入できる。
        # client.reply_message(event['replyToken'],           message = {
        #   type: 'text',
        #   text: 'elseだよ'
        # })
      when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
        response = client.get_message_content(event.message['id'])
        tf = Tempfile.open("content")
        tf.write(response.body)
      end
    end
  }

  "OK"
end