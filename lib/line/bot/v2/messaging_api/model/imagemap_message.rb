# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './message'

# @see https://developers.line.biz/en/reference/messaging-api/#imagemap-message
module Line
  module Bot
    module V2
      module MessagingApi
        class ImagemapMessage < Message
          attr_accessor :type # Type of message
          attr_accessor :quick_reply
          attr_accessor :sender
          attr_accessor :base_url
          attr_accessor :alt_text
          attr_accessor :base_size
          attr_accessor :actions
          attr_accessor :video

          def initialize(
            type:,
            quick_reply: nil,
            sender: nil,
            base_url:,
            alt_text:,
            base_size:,
            actions:,
            video: nil
          )
            @type = type
            @quick_reply = quick_reply
            @sender = sender
            @base_url = base_url
            @alt_text = alt_text
            @base_size = base_size
            @actions = actions
            @video = video
          end
        end
      end
    end
  end
end