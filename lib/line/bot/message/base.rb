require 'line/bot/message/recipient_type'

module Line
  module Bot
    module Message
      class Base
        attr_reader :attrs, :recipient_type

        def initialize(attrs = {})
          @attrs = attrs
        end

        def recipient_type
          @attrs[:recipient_type] ||= Line::Bot::Message::RecipientType::USER
        end

        def [](key)
          @attrs[key]
        end

        def event_type
          Line::Bot::EventType::MESSAGE
        end

        def content
          raise NotImplementedError, "Implement this method in a child class"
        end

        def valid?
          raise NotImplementedError, "Implement this method in a child class"
        end
      end
    end
  end
end
