require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Image < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::IMAGE,
            toType: recipient_type,
            originalContentUrl: attrs[:image_url],
            previewImageUrl: attrs[:preview_url],
          }
        end

        def valid?
          attrs[:image_url] && attrs[:preview_url]
        end
      end
    end
  end
end
