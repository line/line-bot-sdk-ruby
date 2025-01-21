# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Get number of message deliveries
# @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-delivery-messages
module Line
  module Bot
    module V2
      module Insight
        class GetNumberOfMessageDeliveriesResponse
          attr_accessor :status # Status of the counting process.
          attr_accessor :broadcast # Number of messages sent to all of this LINE Official Account's friends (broadcast messages).
          attr_accessor :targeting # Number of messages sent to some of this LINE Official Account's friends, based on specific attributes (targeted messages).
          attr_accessor :auto_response # Number of auto-response messages sent.
          attr_accessor :welcome_response # Number of greeting messages sent.
          attr_accessor :chat # Number of messages sent from LINE Official Account Manager [Chat screen](https://www.linebiz.com/jp/manual/OfficialAccountManager/chats/) (only available in Japanese).
          attr_accessor :api_broadcast # Number of broadcast messages sent with the `Send broadcast message` Messaging API operation.
          attr_accessor :api_push # Number of push messages sent with the `Send push message` Messaging API operation.
          attr_accessor :api_multicast # Number of multicast messages sent with the `Send multicast message` Messaging API operation.
          attr_accessor :api_narrowcast # Number of narrowcast messages sent with the `Send narrowcast message` Messaging API operation.
          attr_accessor :api_reply # Number of replies sent with the `Send reply message` Messaging API operation.

          def initialize(
            status: nil,
            broadcast: nil,
            targeting: nil,
            auto_response: nil,
            welcome_response: nil,
            chat: nil,
            api_broadcast: nil,
            api_push: nil,
            api_multicast: nil,
            api_narrowcast: nil,
            api_reply: nil
          )
            
            @status = status
            @broadcast = broadcast
            @targeting = targeting
            @auto_response = auto_response
            @welcome_response = welcome_response
            @chat = chat
            @api_broadcast = api_broadcast
            @api_push = api_push
            @api_multicast = api_multicast
            @api_narrowcast = api_narrowcast
            @api_reply = api_reply
          end
        end
      end
    end
  end
end
