module Line
  module Bot
    module Message
      class Base
        attr_reader :attrs

        def initialize(attrs = {})
          @attrs = attrs
        end

        def [](key)
          @attrs[key]
        end

        def event_type
          138311608800106203
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
