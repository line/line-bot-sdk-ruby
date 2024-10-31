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
        class FlexText < FlexComponent
          attr_accessor :type
          attr_accessor :flex
          attr_accessor :text
          attr_accessor :size
          attr_accessor :align
          attr_accessor :gravity
          attr_accessor :color
          attr_accessor :weight
          attr_accessor :style
          attr_accessor :decoration
          attr_accessor :wrap
          attr_accessor :line_spacing
          attr_accessor :margin
          attr_accessor :position
          attr_accessor :offset_top
          attr_accessor :offset_bottom
          attr_accessor :offset_start
          attr_accessor :offset_end
          attr_accessor :action
          attr_accessor :max_lines
          attr_accessor :contents
          attr_accessor :adjust_mode
          attr_accessor :scaling

          def initialize(
            type:,
            flex: nil,
            text: nil,
            size: nil,
            align: nil,
            gravity: nil,
            color: nil,
            weight: nil,
            style: nil,
            decoration: nil,
            wrap: nil,
            line_spacing: nil,
            margin: nil,
            position: nil,
            offset_top: nil,
            offset_bottom: nil,
            offset_start: nil,
            offset_end: nil,
            action: nil,
            max_lines: nil,
            contents: nil,
            adjust_mode: nil,
            scaling: nil
          )
            @type = type
            @flex = flex
            @text = text
            @size = size
            @align = align
            @gravity = gravity
            @color = color
            @weight = weight
            @style = style
            @decoration = decoration
            @wrap = wrap
            @line_spacing = line_spacing
            @margin = margin
            @position = position
            @offset_top = offset_top
            @offset_bottom = offset_bottom
            @offset_start = offset_start
            @offset_end = offset_end
            @action = action
            @max_lines = max_lines
            @contents = contents
            @adjust_mode = adjust_mode
            @scaling = scaling
          end
        end
      end
    end
  end
end
