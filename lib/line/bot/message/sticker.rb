require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Sticker < Line::Bot::Message::Base

        def content
          {
            contentType: ContentType::STICKER,
            toType: recipient_type,
            contentMetadata: {
              STKPKGID: attrs[:stkpkgid].to_s,
              STKID: attrs[:stkid].to_s,
              STKVER: attrs[:stkver].to_s,
            },
          }
        end

        def valid?
          attrs[:stkpkgid] && attrs[:stkid] && attrs[:stkver]
        end
      end
    end
  end
end
