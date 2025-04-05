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
        # @see https://developers.line.biz/en/reference/messaging-api/#flex-message
        class FlexMessage < Message
          # @!attribute [r] type
          #   @return [String] Type of message
          attr_reader :type
          # @!attribute [rw] quick_reply
          #   @return [QuickReply,nil] 
          attr_accessor :quick_reply
          # @!attribute [rw] sender
          #   @return [Sender,nil] 
          attr_accessor :sender
          # @!attribute [rw] alt_text
          #   @return [String] 
          attr_accessor :alt_text
          # @!attribute [rw] contents
          #   @return [FlexContainer] 
          attr_accessor :contents

          # @param quick_reply [QuickReply,nil] 
          # @param sender [Sender,nil] 
          # @param alt_text [String] 
          # @param contents [FlexContainer] 
          def initialize(
            quick_reply: nil,
            sender: nil,
            alt_text:,
            contents:,
            **dynamic_attributes
          )
            @type = "flex"
            
            @quick_reply = quick_reply.is_a?(Line::Bot::V2::MessagingApi::QuickReply) || quick_reply.nil? ? quick_reply : Line::Bot::V2::MessagingApi::QuickReply.create(**quick_reply)
            @sender = sender.is_a?(Line::Bot::V2::MessagingApi::Sender) || sender.nil? ? sender : Line::Bot::V2::MessagingApi::Sender.create(**sender)
            @alt_text = alt_text
            @contents = contents.is_a?(Line::Bot::V2::MessagingApi::FlexContainer) ? contents : Line::Bot::V2::MessagingApi::FlexContainer.create(**contents)

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
