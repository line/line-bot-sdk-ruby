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
          attr_accessor :custom_aggregation_units # An array of strings indicating the names of aggregation units used this month.
          attr_accessor :_next # A continuation token to get the next array of unit names. Returned only when there are remaining aggregation units that weren't returned in customAggregationUnits in the original request.  

          def initialize(
            custom_aggregation_units:,
            _next: nil,
            **dynamic_attributes
          )
            
            @custom_aggregation_units = custom_aggregation_units
            @_next = _next

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end
    end
  end
end
