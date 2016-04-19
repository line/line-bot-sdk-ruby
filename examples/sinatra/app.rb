require 'sinatra'
require 'line/bot'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_id = ENV["LINE_CHANNEL_ID"]
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_mid = ENV["LINE_CHANNEL_MID"]
  }
end

get '/' do
  "Hello, world"
end

post '/callback' do
  signature = request.env['HTTP_X_LINE_CHANNELSIGNATURE']
  unless client.validate_signature(request.body.read, signature)
    error 400 do 'Bad Request' end
  end

  request = Line::Bot::Receive::Request.new(request.env)

  request.data.each { |message|
    case message
    when Line::Bot::Receive::Message
      case message.content
      when Line::Bot::Message::Text
        result = client.send_text(
          to_mid: message.from_mid,
          text: message.content[:text],
        )
      when Line::Bot::Message::Image, Line::Bot::Message::Video
      end
    when Line::Bot::Receive::Operation
      case message.content
      when Line::Bot::Operation::AddFriend
        client.send_sticker(
          to_mid: message.from_mid,
          stkpkgid: 2,
          stkid: 144,
          stkver: 100
        )
      end
    end
  }

  "OK"
end
