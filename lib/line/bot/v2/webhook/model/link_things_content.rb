# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './things_content'

module Line
  module Bot
    module V2
      module Webhook
        class LinkThingsContent < ThingsContent
          attr_reader :type # Type
          attr_accessor :device_id # Device ID of the device that has been linked with LINE.

          def initialize(
            type:,
            device_id:
          )
            @type = "link"
            
            @device_id = device_id
          end
        end
      end
    end
  end
end
