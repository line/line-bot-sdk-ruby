# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Provider of the media file.
module Line
  module Bot
    module V2
      module Webhook
        class ContentProvider
          attr_accessor :type # Provider of the image file.
          attr_accessor :original_content_url # URL of the image file. Only included when contentProvider.type is external.
          attr_accessor :preview_image_url # URL of the preview image. Only included when contentProvider.type is external.

          def initialize(
            type:,
            original_content_url: nil,
            preview_image_url: nil
          )
            @type = type
            @original_content_url = original_content_url
            @preview_image_url = preview_image_url
          end
        end
      end
    end
  end
end