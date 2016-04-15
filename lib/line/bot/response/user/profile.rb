require 'json'
require 'line/bot/response/user/contact'

module Line
  module Bot
    module Response
      module User
        class Profile
          attr_reader :start, :count, :total, :contacts, :display

          def initialize(response)
            json = JSON.parse(response.body)

            @start = json['start']
            @count = json['count']
            @total = json['total']
            @contacts = create_contacts(json['contacts']) || []
            @display = json['display']
          end

          def create_contacts(contacts)
            contacts.map { |c|
              Contact.new(c)
            }
          end
        end
      end
    end
  end
end
