# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './message_content'

module Line
  module Bot
    module V2
      module Webhook
        class TextMessageContent < MessageContent
          attr_reader :type # Type
          attr_accessor :id # Message ID
          attr_accessor :text # Message text.
          attr_accessor :emojis # Array of one or more LINE emoji objects. Only included in the message event when the text property contains a LINE emoji.
          attr_accessor :mention
          attr_accessor :quote_token # Quote token to quote this message. 
          attr_accessor :quoted_message_id # Message ID of a quoted message. Only included when the received message quotes a past message.

          # @param id [String] Message ID
          # @param text [String] Message text.
          # @param emojis [Array[Emoji]] Array of one or more LINE emoji objects. Only included in the message event when the text property contains a LINE emoji.
          # @param mention [Mention] 
          # @param quote_token [String] Quote token to quote this message. 
          # @param quoted_message_id [String] Message ID of a quoted message. Only included when the received message quotes a past message.
          def initialize(
            id:,
            text:,
            emojis: nil,
            mention: nil,
            quote_token:,
            quoted_message_id: nil,
            **dynamic_attributes
          )
            @type = "text"
            
            @id = id
            @text = text
            @emojis = emojis&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Webhook::Emoji.create(**item)
              else
                item
              end
            end
            @mention = mention.is_a?(Line::Bot::V2::Webhook::Mention) || mention.nil? ? mention : Line::Bot::V2::Webhook::Mention.create(**mention)
            @quote_token = quote_token
            @quoted_message_id = quoted_message_id

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
