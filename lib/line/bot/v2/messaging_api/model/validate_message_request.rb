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
        class ValidateMessageRequest
          attr_accessor :messages # Array of message objects to validate

          def initialize(
            messages:
          )
            @messages = messages
          end
        end
      end
    end
  end
end