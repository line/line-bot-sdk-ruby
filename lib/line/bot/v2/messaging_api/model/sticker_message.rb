# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './message'

module Line
  module Bot
    module V2
      module MessagingApi
        # @see https://developers.line.biz/en/reference/messaging-api/#sticker-message
        class StickerMessage < Message
          attr_reader :type # Type of message
          attr_accessor :quick_reply
          attr_accessor :sender
          attr_accessor :package_id
          attr_accessor :sticker_id
          attr_accessor :quote_token # Quote token of the message you want to quote.

          def initialize(
            quick_reply: nil,
            sender: nil,
            package_id:,
            sticker_id:,
            quote_token: nil,
            **dynamic_attributes
          )
            @type = "sticker"
            
            @quick_reply = quick_reply.is_a?(Line::Bot::V2::MessagingApi::QuickReply) || quick_reply.nil? ? quick_reply : Line::Bot::V2::MessagingApi::QuickReply.create(**quick_reply)
            @sender = sender.is_a?(Line::Bot::V2::MessagingApi::Sender) || sender.nil? ? sender : Line::Bot::V2::MessagingApi::Sender.create(**sender)
            @package_id = package_id
            @sticker_id = sticker_id
            @quote_token = quote_token

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
