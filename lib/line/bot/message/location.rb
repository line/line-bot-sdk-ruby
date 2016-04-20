require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Location < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::LOCATION,
            toType: recipient_type,
            text: attrs[:address] || attrs[:title],
            location: {
              title: attrs[:title],
              address: attrs[:address],
              latitude: attrs[:latitude],
              longitude: attrs[:longitude],
            }
          }
        end

        def valid?
          attrs[:title] && attrs[:latitude] && attrs[:longitude]
        end
      end
    end
  end
end
