module Line
  module Bot
    module Event
      class Base
        def initialize(src)
          @src = src
        end

        def [](key)
          @src[key]
        end

        def to_s
          inspect
        end

      end
    end
  end
end
