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
        # @see https://developers.line.biz/en/reference/messaging-api/#send-multicast-message
        class MulticastRequest
          # @!attribute [rw] messages
          #   @return [Array[Message]] Messages to send
          attr_accessor :messages
          # @!attribute [rw] to
          #   @return [Array[String]] Array of user IDs. Use userId values which are returned in webhook event objects. Do not use LINE IDs found on LINE.
          attr_accessor :to
          # @!attribute [rw] notification_disabled
          #   @return [Boolean,nil] `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 
          attr_accessor :notification_disabled
          # @!attribute [rw] custom_aggregation_units
          #   @return [Array[String],nil] Name of aggregation unit. Case-sensitive.
          attr_accessor :custom_aggregation_units

          # @param messages [Array[Message]] Messages to send
          # @param to [Array[String]] Array of user IDs. Use userId values which are returned in webhook event objects. Do not use LINE IDs found on LINE.
          # @param notification_disabled [Boolean,nil] `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 
          # @param custom_aggregation_units [Array[String],nil] Name of aggregation unit. Case-sensitive.
          def initialize(
            messages:,
            to:,
            notification_disabled: false,
            custom_aggregation_units: nil,
            **dynamic_attributes
          )
            
            @messages = messages.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::Message.create(**item)
              else
                item
              end
            end
            @to = to.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::string.create(**item)
              else
                item
              end
            end
            @notification_disabled = notification_disabled
            @custom_aggregation_units = custom_aggregation_units&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::string.create(**item)
              else
                item
              end
            end

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
