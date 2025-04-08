# LIFF server API
# LIFF Server API.
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Liff
        class LiffFeatures
          # @!attribute [rw] ble
          #   @return [Boolean,nil] `true` if the LIFF app supports Bluetooth® Low Energy for LINE Things. `false` otherwise. 
          attr_accessor :ble
          # @!attribute [rw] qr_code
          #   @return [Boolean,nil] `true` to use the 2D code reader in the LIFF app. false otherwise. The default value is `false`. 
          attr_accessor :qr_code

          # @param ble [Boolean,nil] `true` if the LIFF app supports Bluetooth® Low Energy for LINE Things. `false` otherwise. 
          # @param qr_code [Boolean,nil] `true` to use the 2D code reader in the LIFF app. false otherwise. The default value is `false`. 
          def initialize(
            ble: nil,
            qr_code: false,
            **dynamic_attributes
          )
            
            @ble = ble
            @qr_code = qr_code

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
