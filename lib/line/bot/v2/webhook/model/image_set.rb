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
        class ImageSet
          attr_accessor :id # Image set ID. Only included when multiple images are sent simultaneously.
          attr_accessor :index # An index starting from 1, indicating the image number in a set of images sent simultaneously. Only included when multiple images are sent simultaneously. However, it won't be included if the sender is using LINE 11.15 or earlier for Android.
          attr_accessor :total # The total number of images sent simultaneously.

          def initialize(
            id:,
            index: nil,
            total: nil
          )
            @id = id
            @index = index
            @total = total
          end
        end
      end
    end
  end
end