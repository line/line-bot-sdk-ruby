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
        # Webhook event
        class Event
          # @!attribute [rw] type
          #   @return [String] Type of the event
          attr_accessor :type
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

          # @param type [String] Type of the event
          # @param source [Source,nil] 
          # @param timestamp [Integer] Time of the event in milliseconds.
          # @param mode [String] ('active'|'standby') 
          # @param webhook_event_id [String] Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          # @param delivery_context [DeliveryContext] 
          def initialize(
            type:,
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            **dynamic_attributes
          )
            
            @type = type
            @source = source.is_a?(Line::Bot::V2::Webhook::Source) || source.nil? ? source : Line::Bot::V2::Webhook::Source.create(**source) # steep:ignore
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context.is_a?(Line::Bot::V2::Webhook::DeliveryContext) ? delivery_context : Line::Bot::V2::Webhook::DeliveryContext.create(**delivery_context) # steep:ignore

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
            klass = detect_class(type: args[:type])
            return klass.new(**args) if klass # steep:ignore
            return new(**args) # steep:ignore
          end

          private

          def self.detect_class(type:)
            {
              accountLink: Line::Bot::V2::Webhook::AccountLinkEvent,
              activated: Line::Bot::V2::Webhook::ActivatedEvent,
              beacon: Line::Bot::V2::Webhook::BeaconEvent,
              botResumed: Line::Bot::V2::Webhook::BotResumedEvent,
              botSuspended: Line::Bot::V2::Webhook::BotSuspendedEvent,
              deactivated: Line::Bot::V2::Webhook::DeactivatedEvent,
              follow: Line::Bot::V2::Webhook::FollowEvent,
              join: Line::Bot::V2::Webhook::JoinEvent,
              leave: Line::Bot::V2::Webhook::LeaveEvent,
              memberJoined: Line::Bot::V2::Webhook::MemberJoinedEvent,
              memberLeft: Line::Bot::V2::Webhook::MemberLeftEvent,
              membership: Line::Bot::V2::Webhook::MembershipEvent,
              message: Line::Bot::V2::Webhook::MessageEvent,
              module: Line::Bot::V2::Webhook::ModuleEvent,
              delivery: Line::Bot::V2::Webhook::PnpDeliveryCompletionEvent,
              postback: Line::Bot::V2::Webhook::PostbackEvent,
              things: Line::Bot::V2::Webhook::ThingsEvent,
              unfollow: Line::Bot::V2::Webhook::UnfollowEvent,
              unsend: Line::Bot::V2::Webhook::UnsendEvent,
              videoPlayComplete: Line::Bot::V2::Webhook::VideoPlayCompleteEvent,
            }[type.to_sym]
          end
        end
      end
    end
  end
end
