# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Webhook
        class FollowDetail
          attr_accessor :is_unblocked # Whether a user has added your LINE Official Account as a friend or unblocked.

          def initialize(
            is_unblocked:
          )
            
            @is_unblocked = is_unblocked
          end
        end
      end
    end
  end
end
