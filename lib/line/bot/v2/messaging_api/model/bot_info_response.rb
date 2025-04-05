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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-bot-info
        class BotInfoResponse
          attr_accessor :user_id # Bot's user ID
          attr_accessor :basic_id # Bot's basic ID
          attr_accessor :premium_id # Bot's premium ID. Not included in the response if the premium ID isn't set.
          attr_accessor :display_name # Bot's display name
          attr_accessor :picture_url # Profile image URL. `https` image URL. Not included in the response if the bot doesn't have a profile image.
          attr_accessor :chat_mode # Chat settings set in the LINE Official Account Manager. One of:  `chat`: Chat is set to \"On\". `bot`: Chat is set to \"Off\". 
          attr_accessor :mark_as_read_mode # Automatic read setting for messages. If the chat is set to \"Off\", auto is returned. If the chat is set to \"On\", manual is returned.  `auto`: Auto read setting is enabled. `manual`: Auto read setting is disabled.  

          # @param user_id [String] Bot's user ID
          # @param basic_id [String] Bot's basic ID
          # @param premium_id [String] Bot's premium ID. Not included in the response if the premium ID isn't set.
          # @param display_name [String] Bot's display name
          # @param picture_url [String] Profile image URL. `https` image URL. Not included in the response if the bot doesn't have a profile image.
          # @param chat_mode [String] ('chat'|'bot') Chat settings set in the LINE Official Account Manager. One of:  `chat`: Chat is set to \"On\". `bot`: Chat is set to \"Off\". 
          # @param mark_as_read_mode [String] ('auto'|'manual') Automatic read setting for messages. If the chat is set to \"Off\", auto is returned. If the chat is set to \"On\", manual is returned.  `auto`: Auto read setting is enabled. `manual`: Auto read setting is disabled.  
          def initialize(
            user_id:,
            basic_id:,
            premium_id: nil,
            display_name:,
            picture_url: nil,
            chat_mode:,
            mark_as_read_mode:,
            **dynamic_attributes
          )
            
            @user_id = user_id
            @basic_id = basic_id
            @premium_id = premium_id
            @display_name = display_name
            @picture_url = picture_url
            @chat_mode = chat_mode
            @mark_as_read_mode = mark_as_read_mode

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key

              if value.is_a?(Hash)
                struct_klass = Struct.new(*value.keys.map(&:to_sym))
                struct_values = value.map { |_k, v| v.is_a?(Hash) ? Line::Bot::V2::Utils.hash_to_struct(v) : v }
                instance_variable_set("@#{key}", struct_klass.new(*struct_values))
              else
                instance_variable_set("@#{key}", value)
              end
            end
          end

          def self.create(args)
            return new(**args)
          end
        end
      end
    end
  end
end
