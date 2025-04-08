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
        # @see https://developers.line.biz/en/reference/messaging-api/#message-common-properties
        class Message
          # @!attribute [rw] type
          #   @return [String] Type of message
          attr_accessor :type
          # @!attribute [rw] quick_reply
          #   @return [QuickReply,nil] 
          attr_accessor :quick_reply
          # @!attribute [rw] sender
          #   @return [Sender,nil] 
          attr_accessor :sender

          # @param type [String] Type of message
          # @param quick_reply [QuickReply,nil] 
          # @param sender [Sender,nil] 
          def initialize(
            type:,
            quick_reply: nil,
            sender: nil,
            **dynamic_attributes
          )
            
            @type = type
            @quick_reply = quick_reply.is_a?(Line::Bot::V2::MessagingApi::QuickReply) || quick_reply.nil? ? quick_reply : Line::Bot::V2::MessagingApi::QuickReply.create(**quick_reply) # steep:ignore
            @sender = sender.is_a?(Line::Bot::V2::MessagingApi::Sender) || sender.nil? ? sender : Line::Bot::V2::MessagingApi::Sender.create(**sender) # steep:ignore

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
            klass = detect_class(type: args[:type])
            return klass.new(**args) if klass # steep:ignore
            return new(**args) # steep:ignore
          end

          private

          def self.detect_class(type:)
            {
              audio: Line::Bot::V2::MessagingApi::AudioMessage,
              flex: Line::Bot::V2::MessagingApi::FlexMessage,
              image: Line::Bot::V2::MessagingApi::ImageMessage,
              imagemap: Line::Bot::V2::MessagingApi::ImagemapMessage,
              location: Line::Bot::V2::MessagingApi::LocationMessage,
              sticker: Line::Bot::V2::MessagingApi::StickerMessage,
              template: Line::Bot::V2::MessagingApi::TemplateMessage,
              text: Line::Bot::V2::MessagingApi::TextMessage,
              textV2: Line::Bot::V2::MessagingApi::TextMessageV2,
              video: Line::Bot::V2::MessagingApi::VideoMessage,
            }[type.to_sym]
          end
        end
      end
    end
  end
end
