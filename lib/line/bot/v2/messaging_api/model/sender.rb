# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Change icon and display name
module Line
  module Bot
    module V2
      module MessagingApi
        class Sender
          attr_accessor :name # Display name. Certain words such as `LINE` may not be used.
          attr_accessor :icon_url # URL of the image to display as an icon when sending a message

          def initialize(
            name: nil,
            icon_url: nil
          )
            @name = name
            @icon_url = icon_url
          end
        end
      end
    end
  end
end