require 'json'

module Line
  module Bot
    module Response
      module User

        class Contact
          attr_reader :mid, :display_name, :picture_url, :status_message

          def initialize(attrs)
            @mid = attrs['mid']
            @display_name = attrs['displayName']
            @picture_url = attrs['pictureUrl']
            @status_message = attrs['statusMessage']
          end
        end

      end
    end
  end
end
