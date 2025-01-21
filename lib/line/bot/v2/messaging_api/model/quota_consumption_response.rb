# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#get-consumption
module Line
  module Bot
    module V2
      module MessagingApi
        class QuotaConsumptionResponse
          attr_accessor :total_usage # The number of sent messages in the current month

          def initialize(
            total_usage:
          )
            
            @total_usage = total_usage
          end
        end
      end
    end
  end
end
