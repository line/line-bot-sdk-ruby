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
        # @see https://developers.line.biz/en/reference/messaging-api/#send-push-message
        class PushMessageRequest
          attr_accessor :to # ID of the receiver.
          attr_accessor :messages # List of Message objects.
          attr_accessor :notification_disabled # `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 
          attr_accessor :custom_aggregation_units # List of aggregation unit name. Case-sensitive. This functions can only be used by corporate users who have submitted the required applications. 

          def initialize(
            to:,
            messages:,
            notification_disabled: false,
            custom_aggregation_units: nil,
            **dynamic_attributes
          )
            
            @to = to
            @messages = messages.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::Message.create(**item)
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
