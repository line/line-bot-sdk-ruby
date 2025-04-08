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
        # Event object for when a user performs a postback action which initiates a postback. You can reply to postback events.
        class PostbackEvent < Event
          # @!attribute [r] type
          #   @return [String] Type of the event
          attr_reader :type
          # @!attribute [rw] source
          #   @return [Source,nil] 
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
          # @!attribute [rw] reply_token
          #   @return [String,nil] Reply token used to send reply message to this event
          attr_accessor :reply_token
          # @!attribute [rw] postback
          #   @return [PostbackContent] 
          attr_accessor :postback

          # @param source [Source,nil] 
          # @param timestamp [Integer] Time of the event in milliseconds.
          # @param mode [String] ('active'|'standby') 
          # @param webhook_event_id [String] Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          # @param delivery_context [DeliveryContext] 
          # @param reply_token [String,nil] Reply token used to send reply message to this event
          # @param postback [PostbackContent] 
          def initialize(
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            reply_token: nil,
            postback:,
            **dynamic_attributes
          )
            @type = "postback"
            
            @source = source.is_a?(Line::Bot::V2::Webhook::Source) || source.nil? ? source : Line::Bot::V2::Webhook::Source.create(**source) # steep:ignore
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context.is_a?(Line::Bot::V2::Webhook::DeliveryContext) ? delivery_context : Line::Bot::V2::Webhook::DeliveryContext.create(**delivery_context) # steep:ignore
            @reply_token = reply_token
            @postback = postback.is_a?(Line::Bot::V2::Webhook::PostbackContent) ? postback : Line::Bot::V2::Webhook::PostbackContent.create(**postback) # steep:ignore

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
        end
      end
    end
  end
end
