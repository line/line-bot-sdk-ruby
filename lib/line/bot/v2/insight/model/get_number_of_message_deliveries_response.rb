# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Insight
        # Get number of message deliveries
        # @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-delivery-messages
        class GetNumberOfMessageDeliveriesResponse
          # @!attribute [rw] status
          #   @return [String,nil] ('ready'|'unready'|'out_of_service') Status of the counting process.
          attr_accessor :status
          # @!attribute [rw] broadcast
          #   @return [Integer,nil] Number of messages sent to all of this LINE Official Account's friends (broadcast messages).
          attr_accessor :broadcast
          # @!attribute [rw] targeting
          #   @return [Integer,nil] Number of messages sent to some of this LINE Official Account's friends, based on specific attributes (targeted messages).
          attr_accessor :targeting
          # @!attribute [rw] auto_response
          #   @return [Integer,nil] Number of auto-response messages sent.
          attr_accessor :auto_response
          # @!attribute [rw] welcome_response
          #   @return [Integer,nil] Number of greeting messages sent.
          attr_accessor :welcome_response
          # @!attribute [rw] chat
          #   @return [Integer,nil] Number of messages sent from LINE Official Account Manager [Chat screen](https://www.linebiz.com/jp/manual/OfficialAccountManager/chats/) (only available in Japanese).
          attr_accessor :chat
          # @!attribute [rw] api_broadcast
          #   @return [Integer,nil] Number of broadcast messages sent with the `Send broadcast message` Messaging API operation.
          attr_accessor :api_broadcast
          # @!attribute [rw] api_push
          #   @return [Integer,nil] Number of push messages sent with the `Send push message` Messaging API operation.
          attr_accessor :api_push
          # @!attribute [rw] api_multicast
          #   @return [Integer,nil] Number of multicast messages sent with the `Send multicast message` Messaging API operation.
          attr_accessor :api_multicast
          # @!attribute [rw] api_narrowcast
          #   @return [Integer,nil] Number of narrowcast messages sent with the `Send narrowcast message` Messaging API operation.
          attr_accessor :api_narrowcast
          # @!attribute [rw] api_reply
          #   @return [Integer,nil] Number of replies sent with the `Send reply message` Messaging API operation.
          attr_accessor :api_reply

          # @param status [String,nil] ('ready'|'unready'|'out_of_service') Status of the counting process.
          # @param broadcast [Integer,nil] Number of messages sent to all of this LINE Official Account's friends (broadcast messages).
          # @param targeting [Integer,nil] Number of messages sent to some of this LINE Official Account's friends, based on specific attributes (targeted messages).
          # @param auto_response [Integer,nil] Number of auto-response messages sent.
          # @param welcome_response [Integer,nil] Number of greeting messages sent.
          # @param chat [Integer,nil] Number of messages sent from LINE Official Account Manager [Chat screen](https://www.linebiz.com/jp/manual/OfficialAccountManager/chats/) (only available in Japanese).
          # @param api_broadcast [Integer,nil] Number of broadcast messages sent with the `Send broadcast message` Messaging API operation.
          # @param api_push [Integer,nil] Number of push messages sent with the `Send push message` Messaging API operation.
          # @param api_multicast [Integer,nil] Number of multicast messages sent with the `Send multicast message` Messaging API operation.
          # @param api_narrowcast [Integer,nil] Number of narrowcast messages sent with the `Send narrowcast message` Messaging API operation.
          # @param api_reply [Integer,nil] Number of replies sent with the `Send reply message` Messaging API operation.
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
            api_reply: nil,
            **dynamic_attributes
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

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key

              if value.is_a?(Hash)
                struct_klass = Struct.new(*value.keys.map(&:to_sym))
                struct_values = value.map { |_k, v| v.is_a?(Hash) ? Line::Bot::V2::Utils.hash_to_struct(v) : v }
                instance_variable_set("@#{key}", struct_klass.new(*struct_values))
              else
                instance_variable_set("@#{key}", value)
              end
            end
          end

          def self.create(args)
            return new(**args)
          end
        end
      end
    end
  end
end
