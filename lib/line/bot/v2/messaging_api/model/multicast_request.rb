# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#send-multicast-message
module Line
  module Bot
    module V2
      module MessagingApi
        class MulticastRequest
          attr_accessor :messages # Messages to send
          attr_accessor :to # Array of user IDs. Use userId values which are returned in webhook event objects. Do not use LINE IDs found on LINE.
          attr_accessor :notification_disabled # `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 
          attr_accessor :custom_aggregation_units # Name of aggregation unit. Case-sensitive.

          def initialize(
            messages:,
            to:,
            notification_disabled: false,
            custom_aggregation_units: nil
          )
            
            @messages = messages
            @to = to
            @notification_disabled = notification_disabled
            @custom_aggregation_units = custom_aggregation_units
          end
        end
      end
    end
  end
end
