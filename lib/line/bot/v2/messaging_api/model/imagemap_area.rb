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
        class ImagemapArea
          attr_accessor :x
          attr_accessor :y
          attr_accessor :width
          attr_accessor :height

          def initialize(
            x:,
            y:,
            width:,
            height:
          )
            @x = x
            @y = y
            @width = width
            @height = height
          end
        end
      end
    end
  end
end
