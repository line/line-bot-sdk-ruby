# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Webhook
        # The request body contains a JSON object with the user ID of a bot that should receive webhook events and an array of webhook event objects. 
        # @see https://developers.line.biz/en/reference/messaging-api/#request-body
        class CallbackRequest
          # @!attribute [rw] destination
          #   @return [String] User ID of a bot that should receive webhook events. The user ID value is a string that matches the regular expression, `U[0-9a-f]{32}`. 
          attr_accessor :destination
          # @!attribute [rw] events
          #   @return [Array[Event]] Array of webhook event objects. The LINE Platform may send an empty array that doesn't include a webhook event object to confirm communication. 
          attr_accessor :events

          # @param destination [String] User ID of a bot that should receive webhook events. The user ID value is a string that matches the regular expression, `U[0-9a-f]{32}`. 
          # @param events [Array[Event]] Array of webhook event objects. The LINE Platform may send an empty array that doesn't include a webhook event object to confirm communication. 
          def initialize(
            destination:,
            events:,
            **dynamic_attributes
          )
            
            @destination = destination
            @events = events.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Webhook::Event.create(**item) # steep:ignore InsufficientKeywordArguments
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

          def self.create(args) # steep:ignore
            return new(**args) # steep:ignore
          end

          # @param other [Object] Object to compare
          # @return [Boolean] true if the objects are equal, false otherwise
          def ==(other)
            return false unless self.class == other.class

            instance_variables.all? do |var|
                instance_variable_get(var) == other.instance_variable_get(var)
            end
          end

          # @return [Integer] Hash code of the object
          def hash
            [self.class, *instance_variables.map { |var| instance_variable_get(var) }].hash
          end
        end
      end
    end
  end
end
