require 'sinatra'   # gem 'sinatra'
require 'line/bot'  # gem 'line-bot-api'

# TODO: bye
# TODO: confirm
# TODO: buttons
# TODO: image_carousel
# TODO: imagemap

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
    when Line::Bot::Event::Follow
      client.reply_message(event['replyToken'], [{
        type: 'text',
        text: "Thank you for following: #{JSON.generate(event['source'])}"
      }])
    when Line::Bot::Event::Postback
      data = event['postback']['data']
      params = event['postback']['params']
      puts "Got data #{data}"
      client.reply_message(event['replyToken'], [{
        type: 'text',
        text: "Got postback message #{data}"
      }, {
        type: 'text',
        text: "Params: #{JSON.generate(params)}"
      }])
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        case event.message['text']
        when 'profile'
          if event['source']['type'] == 'user'
            profile = client.get_profile(event['source']['userId'])
            profile = JSON.parse(profile.read_body)
            client.reply_message(event['replyToken'], [{
              type: 'text',
              text: "Display name: #{profile['displayName']}"
            }, {
              type: 'text',
              text: "Status message: #{profile['statusMessage']}"
            }])
          else
            client.reply_message(event['replyToken'], {
              type: 'text',
              text: "Bot can't use profile API without user ID"
            })
          end
        when 'carousel'
         res = client.reply_message(event['replyToken'], {
            type: 'template',
            altText: 'Carousel alt text',
            template: {
              type: 'carousel',
              columns: [
                {
                  title: 'hoge',
                  text: 'fuga',
                  actions: [
                    {
                      type: 'uri',
                      label: "Go to line.me",
                      uri: 'https://line.me',
                    },
                    {
                      type: 'uri',
                      label: "Go to line.me",
                      uri: 'https://line.me',
                    },
                    {
                      type: 'postback',
                      label: "Say hello1",
                      data: 'hello こんにちは',
                    },
                  ],
                },
                {
                  title: 'Datetime Picker',
                  text: 'Please select a date, time or datetime',
                  actions: [
                    {
                      type: 'datetimepicker',
                      label: "Datetime",
                      data: 'action=sel',
                      mode: 'datetime',
                      initial: '2017-06-18T06:15',
                      max: '2100-12-31T23:59',
                      min: '1900-01-01T00:00',
                    },
                    {
                      type: 'datetimepicker',
                      label: "Date",
                      data: 'action=sel&only=date',
                      mode: 'date',
                      initial: '2017-06-18',
                      max: '2100-12-31',
                      min: '1900-01-01',
                    },
                    {
                      type: 'datetimepicker',
                      label: "Time",
                      data: 'action=sel&only=time',
                      mode: 'time',
                      initial: '12:15',
                      max: '23:00',
                      min: '10:00',
                    },
                  ],
                },
              ]
            }
          })
         puts res.read_body if res.code != 200
        else
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        end
      when Line::Bot::Event::MessageType::Sticker
        puts "Got sticker: packageId:#{event.message['packageId']} stickerId:#{event.message['stickerId']}"

        # Message API available stickers
        # https://developers.line.me/media/messaging-api/sticker_list.pdf
        msgapi_available = event.message['packageId'].to_i <= 4
        if msgapi_available
          res = client.reply_message(event['replyToken'], [{
            type: 'text',
            text: "packageId: #{event.message['packageId']} stickerId: #{event.message['stickerId']}",
          }, {
            type: 'sticker',
            packageId: event.message['packageId'],
            stickerId: event.message['stickerId'],
          }])
          puts res.read_body if res.code != 200
        else
          res = client.reply_message(event['replyToken'], [{
            type: 'text',
            text: "packageId: #{event.message['packageId']} stickerId: #{event.message['stickerId']}",
          }])
          puts res.read_body if res.code != 200
        end
      else
        puts "Unknown message type: #{event.type}"
        client.reply_message(event['replyToken'], {
          type: 'text',
          text: "Unknown message type: #{event.type}"
        })
      end
    else
      puts "Unknown event type: #{event}"
    end
  }

  "OK"
end
