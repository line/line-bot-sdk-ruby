# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# An array of memberships.
module Line
  module Bot
    module V2
      module MessagingApi
        class Subscription
          attr_accessor :membership
          attr_accessor :user

          def initialize(
            membership:,
            user:
          )
            
            @membership = membership
            @user = user
          end
        end
      end
    end
  end
end
