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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-members-room-count
        class RoomMemberCountResponse
          attr_accessor :count # The count of members in the multi-person chat. The number returned excludes the LINE Official Account.

          def initialize(
            count:
          )
            
            @count = count
          end
        end
      end
    end
  end
end
