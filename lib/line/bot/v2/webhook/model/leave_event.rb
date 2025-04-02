# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './event'

module Line
  module Bot
    module V2
      module Webhook
        # Event object for when a user removes your LINE Official Account from a group chat or when your LINE Official Account leaves a group chat or multi-person chat.
        class LeaveEvent < Event
          attr_reader :type # Type of the event
          attr_accessor :source
          attr_accessor :timestamp # Time of the event in milliseconds.
          attr_accessor :mode
          attr_accessor :webhook_event_id # Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          attr_accessor :delivery_context

          def initialize(
            type:,
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            **dynamic_attributes
          )
            @type = "leave"
            
            @source = source
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end
    end
  end
end
