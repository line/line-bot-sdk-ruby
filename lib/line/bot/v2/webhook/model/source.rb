# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Webhook
        # the source of the event.
        # @see https://developers.line.biz/en/reference/messaging-api/#source-user
        class Source
          attr_accessor :type # source type

          def initialize(
            type: nil
          )
            
            @type = type
          end
        end
      end
    end
  end
end
