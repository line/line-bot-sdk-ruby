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
        # This event indicates that the module channel has been switched to Active Channel by calling the Acquire Control API. Sent to the webhook URL server of the module channel.
        class ActivatedEvent < Event
          attr_reader :type # Type of the event
          attr_accessor :source
          attr_accessor :timestamp # Time of the event in milliseconds.
          attr_accessor :mode
          attr_accessor :webhook_event_id # Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          attr_accessor :delivery_context
          attr_accessor :chat_control

          def initialize(
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            chat_control:,
            **dynamic_attributes
          )
            @type = "activated"
            
            @source = source.is_a?(Line::Bot::V2::Webhook::Source) || source.nil? ? source : Line::Bot::V2::Webhook::Source.create(**source)
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context.is_a?(Line::Bot::V2::Webhook::DeliveryContext) ? delivery_context : Line::Bot::V2::Webhook::DeliveryContext.create(**delivery_context)
            @chat_control = chat_control.is_a?(Line::Bot::V2::Webhook::ChatControl) ? chat_control : Line::Bot::V2::Webhook::ChatControl.create(**chat_control)

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
