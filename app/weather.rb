require "./src/Weather"
require "./src/WeatherInfo"

weatherobj = Weather.new
info = weatherobj.doProcess()

puts "今日、#{info.today()} 東京の天気です。"
puts "天気    ：#{info.todayTelop()}"
puts "最高気温：#{info.todayTempMax()}"
puts "最低気温：#{info.todayTempMin()}"
puts ""

puts "明日、#{info.tmrw()} 東京の天気です。"
puts "天気    ：#{info.tmrwTelop()}"
puts "最高気温：#{info.tmrwTempMax()}"
puts "最低気温：#{info.tmrwTempMin()}"
puts ""


puts "【概要】"
puts info.description()

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
        # メッセージのおうむ返し
        if message.text == 'こんちは'
        # 必ずおはようを返す。
        # message = {
        #   type: 'text',
        #   text: 'おはよう'
        # }
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