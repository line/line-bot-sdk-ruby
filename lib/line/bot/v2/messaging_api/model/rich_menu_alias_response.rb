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
        class RichMenuAliasResponse
          attr_accessor :rich_menu_alias_id # Rich menu alias ID.
          attr_accessor :rich_menu_id # The rich menu ID associated with the rich menu alias.

          def initialize(
            rich_menu_alias_id:,
            rich_menu_id:,
            **dynamic_attributes
          )
            
            @rich_menu_alias_id = rich_menu_alias_id
            @rich_menu_id = rich_menu_id

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
