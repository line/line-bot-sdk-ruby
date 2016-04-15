module Line
  module Bot
    module Operation
      class Base
        attr_reader :attrs

        def initialize(attrs = {})
          @attrs = attrs
        end

        def [](key)
          @attrs[key]
        end
      end
    end
  end
end
