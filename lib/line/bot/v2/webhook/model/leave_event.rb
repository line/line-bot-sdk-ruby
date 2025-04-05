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
          # @!attribute [r] type
          #   @return [String] Type of the event
          attr_reader :type
          # @!attribute [rw] source
          #   @return [Source] 
          attr_accessor :source
          # @!attribute [rw] timestamp
          #   @return [Integer] Time of the event in milliseconds.
          attr_accessor :timestamp
          # @!attribute [rw] mode
          #   @return [String] ('active'|'standby') 
          attr_accessor :mode
          # @!attribute [rw] webhook_event_id
          #   @return [String] Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          attr_accessor :webhook_event_id
          # @!attribute [rw] delivery_context
          #   @return [DeliveryContext] 
          attr_accessor :delivery_context

          # @param source [Source] 
          # @param timestamp [Integer] Time of the event in milliseconds.
          # @param mode [String] ('active'|'standby') 
          # @param webhook_event_id [String] Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          # @param delivery_context [DeliveryContext] 
          def initialize(
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            **dynamic_attributes
          )
            @type = "leave"
            
            @source = source.is_a?(Line::Bot::V2::Webhook::Source) || source.nil? ? source : Line::Bot::V2::Webhook::Source.create(**source)
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context.is_a?(Line::Bot::V2::Webhook::DeliveryContext) ? delivery_context : Line::Bot::V2::Webhook::DeliveryContext.create(**delivery_context)

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
