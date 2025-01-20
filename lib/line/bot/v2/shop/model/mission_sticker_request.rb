# Mission Stickers API
# This document describes LINE Mission Stickers API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Send mission stickers (v3)
# @see https://developers.line.biz/en/reference/partner-docs/#send-mission-stickers-v3
module Line
  module Bot
    module V2
      module Shop
        class MissionStickerRequest
          attr_accessor :to # Destination user ID
          attr_accessor :product_id # Package ID for a set of stickers
          attr_accessor :product_type # `STICKER`
          attr_accessor :send_present_message # `false`

          def initialize(
            to:,
            product_id:,
            product_type:,
            send_present_message:
          )
            
            @to = to
            @product_id = product_id
            @product_type = product_type
            @send_present_message = send_present_message
          end
        end
      end
    end
  end
end
