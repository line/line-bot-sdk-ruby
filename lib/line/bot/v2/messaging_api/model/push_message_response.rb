# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#send-push-message-response
module Line
  module Bot
    module V2
      module MessagingApi
        class PushMessageResponse
          attr_accessor :sent_messages # Array of sent messages.

          def initialize(
            sent_messages:
          )
            @sent_messages = sent_messages
          end
        end
      end
    end
  end
end
