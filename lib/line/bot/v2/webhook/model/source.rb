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
        # the source of the event.
        # @see https://developers.line.biz/en/reference/messaging-api/#source-user
        class Source
          # @!attribute [rw] type
          #   @return [String,nil] source type
          attr_accessor :type

          # @param type [String,nil] source type
          def initialize(
            type: nil,
            **dynamic_attributes
          )
            
            @type = type

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
            klass = detect_class(args[:type])
            return klass.new(**args) if klass
            
            return new(**args)
          end

          private

          def self.detect_class(type)
            {
              group: Line::Bot::V2::Webhook::GroupSource,
              room: Line::Bot::V2::Webhook::RoomSource,
              user: Line::Bot::V2::Webhook::UserSource,
            }[type.to_sym]
          end
        end
      end
    end
  end
end
