# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module MessagingApi
        class ImagemapExternalLink
          attr_accessor :link_uri
          attr_accessor :label

          def initialize(
            link_uri: nil,
            label: nil
          )
            @link_uri = link_uri
            @label = label
          end
        end
      end
    end
  end
end