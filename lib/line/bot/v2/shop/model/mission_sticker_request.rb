# Mission Stickers API
# This document describes LINE Mission Stickers API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Shop
        # Send mission stickers (v3)
        # @see https://developers.line.biz/en/reference/partner-docs/#send-mission-stickers-v3
        class MissionStickerRequest
          attr_accessor :to # Destination user ID
          attr_accessor :product_id # Package ID for a set of stickers
          attr_accessor :product_type # `STICKER`
          attr_accessor :send_present_message # `false`

          def initialize(
            to:,
            product_id:,
            product_type:,
            send_present_message:,
            **dynamic_attributes
          )
            
            @to = to
            @product_id = product_id
            @product_type = product_type
            @send_present_message = send_present_message

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
