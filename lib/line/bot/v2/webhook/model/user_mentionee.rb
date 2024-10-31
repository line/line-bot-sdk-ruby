# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './mentionee'

# Mentioned target is user
module Line
  module Bot
    module V2
      module Webhook
        class UserMentionee < Mentionee
          attr_accessor :type # Mentioned target.
          attr_accessor :index # Index position of the user mention for a character in text, with the first character being at position 0.
          attr_accessor :length # The length of the text of the mentioned user. For a mention @example, 8 is the length.
          attr_accessor :user_id # User ID of the mentioned user. Only included if mention.mentions[].type is user and the user consents to the LINE Official Account obtaining their user profile information.
          attr_accessor :is_self # Whether the mentioned user is the bot that receives the webhook.

          def initialize(
            type:,
            index:,
            length:,
            user_id: nil,
            is_self: nil
          )
            @type = type
            @index = index
            @length = length
            @user_id = user_id
            @is_self = is_self
          end
        end
      end
    end
  end
end
