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
          # @!attribute [r] type
          #   @return [String] Type
          attr_reader :type
          # @!attribute [rw] id
          #   @return [String] Message ID
          attr_accessor :id
          # @!attribute [rw] text
          #   @return [String] Message text.
          attr_accessor :text
          # @!attribute [rw] emojis
          #   @return [Array[Emoji],nil] Array of one or more LINE emoji objects. Only included in the message event when the text property contains a LINE emoji.
          attr_accessor :emojis
          # @!attribute [rw] mention
          #   @return [Mention,nil] 
          attr_accessor :mention
          # @!attribute [rw] quote_token
          #   @return [String] Quote token to quote this message. 
          attr_accessor :quote_token
          # @!attribute [rw] quoted_message_id
          #   @return [String,nil] Message ID of a quoted message. Only included when the received message quotes a past message.
          attr_accessor :quoted_message_id

          # @param id [String] Message ID
          # @param text [String] Message text.
          # @param emojis [Array[Emoji],nil] Array of one or more LINE emoji objects. Only included in the message event when the text property contains a LINE emoji.
          # @param mention [Mention,nil] 
          # @param quote_token [String] Quote token to quote this message. 
          # @param quoted_message_id [String,nil] Message ID of a quoted message. Only included when the received message quotes a past message.
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
                Line::Bot::V2::Webhook::Emoji.create(**item) # steep:ignore InsufficientKeywordArguments
              else
                item
              end
            end
            @mention = mention.is_a?(Line::Bot::V2::Webhook::Mention) || mention.nil? ? mention : Line::Bot::V2::Webhook::Mention.create(**mention) # steep:ignore
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

          def self.create(args) # steep:ignore
            return new(**args) # steep:ignore
          end

          # @param other [Object] Object to compare
          # @return [Boolean] true if the objects are equal, false otherwise
          def ==(other)
            return false unless self.class == other.class

            instance_variables.all? do |var|
                instance_variable_get(var) == other.instance_variable_get(var)
            end
          end

          # @return [Integer] Hash code of the object
          def hash
            [self.class, *instance_variables.map { |var| instance_variable_get(var) }].hash
          end
        end
      end
    end
  end
end
