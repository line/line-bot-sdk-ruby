# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# List of memberships
module Line
  module Bot
    module V2
      module MessagingApi
        class MembershipListResponse
          attr_accessor :memberships # List of membership information

          def initialize(
            memberships:
          )
            
            @memberships = memberships
          end
        end
      end
    end
  end
end
