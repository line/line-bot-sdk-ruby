# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Insight
        class ErrorDetail
          attr_accessor :message # Details of the error. Not included in the response under certain situations.
          attr_accessor :property # Location of where the error occurred. Returns the JSON field name or query parameter name of the request. Not included in the response under certain situations.

          def initialize(
            message: nil,
            property: nil
          )
            
            @message = message
            @property = property
          end
        end
      end
    end
  end
end
