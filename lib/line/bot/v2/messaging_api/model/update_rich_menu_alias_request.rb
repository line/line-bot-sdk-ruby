# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#update-rich-menu-alias
module Line
  module Bot
    module V2
      module MessagingApi
        class UpdateRichMenuAliasRequest
          attr_accessor :rich_menu_id # The rich menu ID to be associated with the rich menu alias.

          def initialize(
            rich_menu_id:
          )
            @rich_menu_id = rich_menu_id
          end
        end
      end
    end
  end
end