require 'line/bot/operation/op_type'

module Line
  module Bot
    module Receive
      class Operation
        attr_reader :id, :from_mid, :to_mid, :from_channel_id, :to_channel_id, :event_type, :content

        def initialize(env)
          @id = env['id']
          @from_mid = env['content']['params'].first
          @to_mid = env['to']

          @from_channel_id = env['fromChannel']
          @to_channel_id = env['toChannel']

          @event_type = env['eventType']
          @content = create_content(env['content'])
        end

        def create_content(attrs)
          case attrs['opType']
          when Line::Bot::Operation::OpType::ADD_FRIEND
            return Line::Bot::Operation::AddFriend.new(
              revision: attrs['revision'],
              op_type: attrs['opType'],
              params: attrs['params'],
            )
          when Line::Bot::Operation::OpType::BLOCK_ACCOUNT
            return Line::Bot::Operation::BlockAccount.new(
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
