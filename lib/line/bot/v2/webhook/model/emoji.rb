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
        class Emoji
          attr_accessor :index # Index position for a character in text, with the first character being at position 0.
          attr_accessor :length # The length of the LINE emoji string. For LINE emoji (hello), 7 is the length.
          attr_accessor :product_id # Product ID for a LINE emoji set.
          attr_accessor :emoji_id # ID for a LINE emoji inside a set.

          def initialize(
            index:,
            length:,
            product_id:,
            emoji_id:,
            **dynamic_attributes
          )
            
            @index = index
            @length = length
            @product_id = product_id
            @emoji_id = emoji_id

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
