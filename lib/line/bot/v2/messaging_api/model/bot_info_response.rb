# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#get-bot-info
module Line
  module Bot
    module V2
      module MessagingApi
        class BotInfoResponse
          attr_accessor :user_id # Bot's user ID
          attr_accessor :basic_id # Bot's basic ID
          attr_accessor :premium_id # Bot's premium ID. Not included in the response if the premium ID isn't set.
          attr_accessor :display_name # Bot's display name
          attr_accessor :picture_url # Profile image URL. `https` image URL. Not included in the response if the bot doesn't have a profile image.
          attr_accessor :chat_mode # Chat settings set in the LINE Official Account Manager. One of:  `chat`: Chat is set to \"On\". `bot`: Chat is set to \"Off\". 
          attr_accessor :mark_as_read_mode # Automatic read setting for messages. If the chat is set to \"Off\", auto is returned. If the chat is set to \"On\", manual is returned.  `auto`: Auto read setting is enabled. `manual`: Auto read setting is disabled.  

          def initialize(
            user_id:,
            basic_id:,
            premium_id: nil,
            display_name:,
            picture_url: nil,
            chat_mode:,
            mark_as_read_mode:
          )
            
            @user_id = user_id
            @basic_id = basic_id
            @premium_id = premium_id
            @display_name = display_name
            @picture_url = picture_url
            @chat_mode = chat_mode
            @mark_as_read_mode = mark_as_read_mode
          end
        end
      end
    end
  end
end
