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
        class SentMessage
          attr_accessor :id # ID of the sent message.
          attr_accessor :quote_token # Quote token of the message. Only included when a message object that can be specified as a quote target was sent as a push or reply message. 

          def initialize(
            id:,
            quote_token: nil
          )
            @id = id
            @quote_token = quote_token
          end
        end
      end
    end
  end
end
