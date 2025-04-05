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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-name-list-of-units-used-this-month
        class GetAggregationUnitNameListResponse
          # @!attribute [rw] custom_aggregation_units
          #   @return [Array[String]] An array of strings indicating the names of aggregation units used this month.
          attr_accessor :custom_aggregation_units
          # @!attribute [rw] _next
          #   @return [String] A continuation token to get the next array of unit names. Returned only when there are remaining aggregation units that weren't returned in customAggregationUnits in the original request.  
          attr_accessor :_next

          # @param custom_aggregation_units [Array[String]] An array of strings indicating the names of aggregation units used this month.
          # @param _next [String] A continuation token to get the next array of unit names. Returned only when there are remaining aggregation units that weren't returned in customAggregationUnits in the original request.  
          def initialize(
            custom_aggregation_units:,
            _next: nil,
            **dynamic_attributes
          )
            
            @custom_aggregation_units = custom_aggregation_units.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::string.create(**item)
              else
                item
              end
            end
            @_next = _next

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
