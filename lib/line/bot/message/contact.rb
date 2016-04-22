require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Contact < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::CONTACT,
            toType: recipient_type,
            contentMetadata: {
              mid: attrs[:mid].to_s,
              displayName: attrs[:display_name].to_s,
            },
          }
        end

        def valid?
          attrs[:mid] && attrs[:display_name]
        end
      end
    end
  end
end
