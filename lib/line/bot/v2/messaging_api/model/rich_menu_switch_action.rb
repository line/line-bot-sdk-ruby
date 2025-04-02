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
        class RichMenuSwitchAction < Action
          attr_reader :type # Type of action
          attr_accessor :label # Label for the action.
          attr_accessor :data
          attr_accessor :rich_menu_alias_id

          def initialize(
            label: nil,
            data: nil,
            rich_menu_alias_id: nil,
            **dynamic_attributes
          )
            @type = "richmenuswitch"
            
            @label = label
            @data = data
            @rich_menu_alias_id = rich_menu_alias_id

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end
    end
  end
end
