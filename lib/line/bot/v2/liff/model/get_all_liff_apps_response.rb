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
        class GetAllLiffAppsResponse
          # @!attribute [rw] apps
          #   @return [Array[LiffApp],nil] 
          attr_accessor :apps

          # @param apps [Array[LiffApp],nil] 
          def initialize(
            apps: nil,
            **dynamic_attributes
          )
            
            @apps = apps&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Liff::LiffApp.create(**item)
              else
                item
              end
            end

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
