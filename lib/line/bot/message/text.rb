require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Text < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::TEXT,
            toType: recipient_type,
            text: attrs[:text]
          }
        end

        def valid?
          !attrs[:text].nil?
        end
      end
    end
  end
end
