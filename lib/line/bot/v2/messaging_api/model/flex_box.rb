# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './flex_component'

module Line
  module Bot
    module V2
      module MessagingApi
        class FlexBox < FlexComponent
          attr_accessor :type
          attr_accessor :layout
          attr_accessor :flex
          attr_accessor :contents
          attr_accessor :spacing
          attr_accessor :margin
          attr_accessor :position
          attr_accessor :offset_top
          attr_accessor :offset_bottom
          attr_accessor :offset_start
          attr_accessor :offset_end
          attr_accessor :background_color
          attr_accessor :border_color
          attr_accessor :border_width
          attr_accessor :corner_radius
          attr_accessor :width
          attr_accessor :max_width
          attr_accessor :height
          attr_accessor :max_height
          attr_accessor :padding_all
          attr_accessor :padding_top
          attr_accessor :padding_bottom
          attr_accessor :padding_start
          attr_accessor :padding_end
          attr_accessor :action
          attr_accessor :justify_content
          attr_accessor :align_items
          attr_accessor :background

          def initialize(
            type:,
            layout:,
            flex: nil,
            contents:,
            spacing: nil,
            margin: nil,
            position: nil,
            offset_top: nil,
            offset_bottom: nil,
            offset_start: nil,
            offset_end: nil,
            background_color: nil,
            border_color: nil,
            border_width: nil,
            corner_radius: nil,
            width: nil,
            max_width: nil,
            height: nil,
            max_height: nil,
            padding_all: nil,
            padding_top: nil,
            padding_bottom: nil,
            padding_start: nil,
            padding_end: nil,
            action: nil,
            justify_content: nil,
            align_items: nil,
            background: nil
          )
            @type = type
            @layout = layout
            @flex = flex
            @contents = contents
            @spacing = spacing
            @margin = margin
            @position = position
            @offset_top = offset_top
            @offset_bottom = offset_bottom
            @offset_start = offset_start
            @offset_end = offset_end
            @background_color = background_color
            @border_color = border_color
            @border_width = border_width
            @corner_radius = corner_radius
            @width = width
            @max_width = max_width
            @height = height
            @max_height = max_height
            @padding_all = padding_all
            @padding_top = padding_top
            @padding_bottom = padding_bottom
            @padding_start = padding_start
            @padding_end = padding_end
            @action = action
            @justify_content = justify_content
            @align_items = align_items
            @background = background
          end
        end
      end
    end
  end
end