require 'line/bot/receive/message'
require 'json'
require 'rack'

module Line
  module Bot
    module Receive
      class Request < Rack::Request

        def data
          @data ||= parse_data_from_body
        end

        def parse_data_from_body
          body.rewind
          json = JSON.parse(body.read)
          result = json['result']

          result.map { |item| create_message_or_operation(item) }
        end

        def create_message_or_operation(data)
          case data['eventType'].to_i
          when Line::Bot::Receive::EventType::MESSAGE
            return Line::Bot::Receive::Message.new(data)
          when Line::Bot::Receive::EventType::OPERATION
            return Line::Bot::Receive::Operation.new(data)
          end
        end

      end

    end
  end
end
