# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Rich menu area
module Line
  module Bot
    module V2
      module MessagingApi
        class RichMenuArea
          attr_accessor :bounds
          attr_accessor :action

          def initialize(
            bounds: nil,
            action: nil
          )
            
            @bounds = bounds
            @action = action
          end
        end
      end
    end
  end
end
