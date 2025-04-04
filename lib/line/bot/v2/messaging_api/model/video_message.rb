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
        # @see https://developers.line.biz/en/reference/messaging-api/#video-message
        class VideoMessage < Message
          attr_reader :type # Type of message
          attr_accessor :quick_reply
          attr_accessor :sender
          attr_accessor :original_content_url
          attr_accessor :preview_image_url
          attr_accessor :tracking_id

          def initialize(
            quick_reply: nil,
            sender: nil,
            original_content_url:,
            preview_image_url:,
            tracking_id: nil,
            **dynamic_attributes
          )
            @type = "video"
            
            @quick_reply = quick_reply.is_a?(Line::Bot::V2::MessagingApi::QuickReply) || quick_reply.nil? ? quick_reply : Line::Bot::V2::MessagingApi::QuickReply.create(**quick_reply)
            @sender = sender.is_a?(Line::Bot::V2::MessagingApi::Sender) || sender.nil? ? sender : Line::Bot::V2::MessagingApi::Sender.create(**sender)
            @original_content_url = original_content_url
            @preview_image_url = preview_image_url
            @tracking_id = tracking_id

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
