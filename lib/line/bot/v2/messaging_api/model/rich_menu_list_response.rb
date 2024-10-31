# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/messaging-api/#get-rich-menu-list
module Line
  module Bot
    module V2
      module MessagingApi
        class RichMenuListResponse
          attr_accessor :richmenus # Rich menus

          def initialize(
            richmenus:
          )
            @richmenus = richmenus
          end
        end
      end
    end
  end
end
