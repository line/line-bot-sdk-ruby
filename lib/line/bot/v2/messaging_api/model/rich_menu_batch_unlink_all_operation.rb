# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './rich_menu_batch_operation'

# Unlink the rich menu from all users linked to the rich menu.
module Line
  module Bot
    module V2
      module MessagingApi
        class RichMenuBatchUnlinkAllOperation < RichMenuBatchOperation
          attr_accessor :type # The type of operation to the rich menu linked to the user. One of link, unlink, or unlinkAll.

          def initialize(
            type:
          )
            @type = type
          end
        end
      end
    end
  end
end
