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
        class PostbackContent
          attr_accessor :data # Postback data
          attr_accessor :params

          def initialize(
            data:,
            params: nil
          )
            @data = data
            @params = params
          end
        end
      end
    end
  end
end
