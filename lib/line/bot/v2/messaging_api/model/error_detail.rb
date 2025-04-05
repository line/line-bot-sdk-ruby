# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module MessagingApi
        class ErrorDetail
          # @!attribute [rw] message
          #   @return [String] Details of the error. Not included in the response under certain situations.
          attr_accessor :message
          # @!attribute [rw] property
          #   @return [String] Location of where the error occurred. Returns the JSON field name or query parameter name of the request. Not included in the response under certain situations.
          attr_accessor :property

          # @param message [String] Details of the error. Not included in the response under certain situations.
          # @param property [String] Location of where the error occurred. Returns the JSON field name or query parameter name of the request. Not included in the response under certain situations.
          def initialize(
            message: nil,
            property: nil,
            **dynamic_attributes
          )
            
            @message = message
            @property = property

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
