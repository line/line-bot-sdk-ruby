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
        # A delivery object containing a hashed phone number string or a string specified by `X-Line-Delivery-Tag` header
        class PnpDelivery
          # @!attribute [rw] data
          #   @return [String] A hashed phone number string or a string specified by `X-Line-Delivery-Tag` header
          attr_accessor :data

          # @param data [String] A hashed phone number string or a string specified by `X-Line-Delivery-Tag` header
          def initialize(
            data:,
            **dynamic_attributes
          )
            
            @data = data

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
