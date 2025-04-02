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
        # Rich menu operation object represents the batch operation to the rich menu linked to the user.
        # @see https://developers.line.biz/en/reference/messaging-api/#batch-control-rich-menus-of-users-operations
        class RichMenuBatchOperation
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
