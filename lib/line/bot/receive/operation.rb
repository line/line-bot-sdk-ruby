require 'line/bot/operation/op_type'

module Line
  module Bot
    module Receive
      class Operation
        attr_reader :id, :from_mid, :to_mid, :from_channel_id, :to_channel_id, :event_type, :content

        def initialize(attrs)
          @id = attrs['id']
          @from_mid = attrs['content']['params'].first
          @to_mid = attrs['to']

          @from_channel_id = attrs['fromChannel']
          @to_channel_id = attrs['toChannel']

          @event_type = attrs['eventType']
          @content = create_content(attrs['content'])
        end

        def create_content(attrs)
          case attrs['opType']
          when Line::Bot::Operation::OpType::ADDED_AS_FRIEND
            return Line::Bot::Operation::AddedAsFriend.new(
              revision: attrs['revision'],
              op_type: attrs['opType'],
              params: attrs['params'],
            )
          when Line::Bot::Operation::OpType::BLOCKED_ACCOUNT
            return Line::Bot::Operation::BlockedAccount.new(
              revision: attrs['revision'],
              op_type: attrs['opType'],
              params: attrs['params'],
            )
          else
          end
        end

      end
    end
  end
end
