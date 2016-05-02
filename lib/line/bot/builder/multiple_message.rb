require 'line/bot/message'

module Line
  module Bot
    module Builder
      class MultipleMessage

        def initialize(client)
          @messages ||= []
          @client = client
        end

        def add_text(attrs = {})
          tap {
            message = Message::Text.new(
              text: attrs[:text],
            )
            push_message(message)
          }
        end

        def add_image(attrs = {})
          tap {
            message = Message::Image.new(
              image_url: attrs[:image_url],
              preview_url: attrs[:preview_url],
            )
            push_message(message)
          }
        end

        def add_video(attrs = {})
          tap {
            message = Message::Video.new(
              video_url: attrs[:video_url],
              preview_url: attrs[:preview_url],
            )
            push_message(message)
          }
        end

        def add_audio(attrs = {})
          tap {
            message = Message::Audio.new(
              audio_url: attrs[:audio_url],
              duration: attrs[:duration],
            )
            push_message(message)
          }
        end

        def add_location(attrs = {})
          tap {
            message = Message::Location.new(
              title: attrs[:title],
              latitude: attrs[:latitude],
              longitude: attrs[:longitude],
            )
            push_message(message)
          }
        end

        def add_sticker(attrs = {})
          tap {
            message = Message::Sticker.new(
              stkpkgid: attrs[:stkpkgid],
              stkid: attrs[:stkid],
              stkver: attrs[:stkver],
            )
            push_message(message)
          }
        end

        def push_message(message)
          raise ArgumentError, "Invalid argument: `message`" unless message.valid?
          @messages << message.content
        end

        def send(attrs = {})
          @client.send_message(attrs[:to_mid], self)
        end

        def event_type
          Line::Bot::EventType::MULTIPLE_MESSAGE
        end

        def content
          {
            messageNotified: 0,
            messages: @messages
          }
        end

        def valid?
          @messages.size > 0
        end

      end
    end
  end
end
