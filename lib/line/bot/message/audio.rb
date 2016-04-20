require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Audio < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::AUDIO,
            toType: recipient_type,
            originalContentUrl: attrs[:audio_url],
            contentMetadata: {
              AUDLEN: attrs[:duration].to_s,
            },
          }
        end

        def valid?
          attrs[:audio_url] && attrs[:duration]
        end
      end
    end
  end
end
