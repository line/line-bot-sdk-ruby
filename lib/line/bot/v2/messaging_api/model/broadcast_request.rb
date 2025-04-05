# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module MessagingApi
        # @see https://developers.line.biz/en/reference/messaging-api/#send-broadcast-message
        class BroadcastRequest
          # @!attribute [rw] messages
          #   @return [Array[Message]] List of Message objects.
          attr_accessor :messages
          # @!attribute [rw] notification_disabled
          #   @return [Boolean,nil] `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 
          attr_accessor :notification_disabled

          # @param messages [Array[Message]] List of Message objects.
          # @param notification_disabled [Boolean,nil] `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 
          def initialize(
            messages:,
            notification_disabled: false,
            **dynamic_attributes
          )
            
            @messages = messages.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::Message.create(**item)
              else
                item
              end
            end
            @notification_disabled = notification_disabled

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
