module Line
  module Bot
    module Event
      module MessageType
        Text = 'text'
        Image = 'image'
        Video = 'video'
        Audio = 'audio'
        Location = 'location'
        Sticker = 'sticker'
        Unsupport = 'unsupport'
      end

      class Message < Base
        def type
          begin
            Line::Bot::Event::MessageType.const_get(@src['message']['type'].capitalize)
          rescue => e # NameError: uninitialized constant
            Line::Bot::Event::MessageType::Unsupport
          end
        end

        def message
          @src['message']
        end
      end
    end
  end
end
