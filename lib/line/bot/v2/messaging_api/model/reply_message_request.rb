# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#send-reply-message
module Line
  module Bot
    module V2
      module MessagingApi
        class ReplyMessageRequest
          attr_accessor :reply_token # replyToken received via webhook.
          attr_accessor :messages # List of messages.
          attr_accessor :notification_disabled # `true`: The user doesn’t receive a push notification when a message is sent. `false`: The user receives a push notification when the message is sent (unless they have disabled push notifications in LINE and/or their device). The default value is false. 

          def initialize(
            reply_token:,
            messages:,
            notification_disabled: false
          )
            @reply_token = reply_token
            @messages = messages
            @notification_disabled = notification_disabled
          end
        end
      end
    end
  end
end
