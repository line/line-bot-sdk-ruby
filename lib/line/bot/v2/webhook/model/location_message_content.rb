# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './message_content'

module Line
  module Bot
    module V2
      module Webhook
        class LocationMessageContent < MessageContent
          attr_accessor :type # Type
          attr_accessor :id # Message ID
          attr_accessor :title # Title
          attr_accessor :address # Address
          attr_accessor :latitude # Latitude
          attr_accessor :longitude # Longitude

          def initialize(
            type:,
            id:,
            title: nil,
            address: nil,
            latitude:,
            longitude:
          )
            @type = type
            @id = id
            @title = title
            @address = address
            @latitude = latitude
            @longitude = longitude
          end
        end
      end
    end
  end
end