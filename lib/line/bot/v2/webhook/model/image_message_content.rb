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
        class ImageMessageContent < MessageContent
          attr_accessor :type # Type
          attr_accessor :id # Message ID
          attr_accessor :content_provider
          attr_accessor :image_set
          attr_accessor :quote_token # Quote token to quote this message. 

          def initialize(
            type:,
            id:,
            content_provider:,
            image_set: nil,
            quote_token:
          )
            @type = type
            @id = id
            @content_provider = content_provider
            @image_set = image_set
            @quote_token = quote_token
          end
        end
      end
    end
  end
end
