require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Video < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::VIDEO,
            toType: recipient_type,
            originalContentUrl: attrs[:video_url],
            previewImageUrl: attrs[:preview_url],
          }
        end

        def valid?
          attrs[:video_url] && attrs[:preview_url]
        end
      end
    end
  end
end
