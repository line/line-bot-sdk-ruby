require 'line/bot/message/base'

module Line
  module Bot
    module Message
      class Contact < Line::Bot::Message::Base

        def content
          raise Line::Bot::API::NotSupportedError
        end

        def valid?
          raise Line::Bot::API::NotSupportedError
        end
      end
    end
  end
end
