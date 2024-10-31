# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './action'

module Line
  module Bot
    module V2
      module MessagingApi
        class MessageAction < Action
          attr_accessor :type # Type of action
          attr_accessor :label # Label for the action.
          attr_accessor :text

          def initialize(
            type: nil,
            label: nil,
            text: nil
          )
            @type = type
            @label = label
            @text = text
          end
        end
      end
    end
  end
end
