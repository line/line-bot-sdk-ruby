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
        class FlexSeparator < FlexComponent
          attr_reader :type
          attr_accessor :margin
          attr_accessor :color

          def initialize(
            margin: nil,
            color: nil
          )
            @type = "separator"
            
            @margin = margin
            @color = color
          end
        end
      end
    end
  end
end
