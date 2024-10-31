# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#error-responses
module Line
  module Bot
    module V2
      module ManageAudience
        class ErrorResponse
          attr_accessor :message # Message containing information about the error.
          attr_accessor :details # An array of error details. If the array is empty, this property will not be included in the response.

          def initialize(
            message:,
            details: nil
          )
            @message = message
            @details = details
          end
        end
      end
    end
  end
end
