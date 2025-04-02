# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './mention_target'

module Line
  module Bot
    module V2
      module MessagingApi
        # @see https://developers.line.biz/en/reference/messaging-api/#text-message-v2-mentionee-user
        class UserMentionTarget < MentionTarget
          attr_reader :type # Target to be mentioned
          attr_accessor :user_id

          def initialize(
            user_id:
          )
            @type = "user"
            
            @user_id = user_id
          end
        end
      end
    end
  end
end
