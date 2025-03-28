# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Insight
        class AreaTile
          attr_accessor :area # users' country and region
          attr_accessor :percentage # Percentage

          def initialize(
            area: nil,
            percentage: nil
          )
            
            @area = area
            @percentage = percentage
          end
        end
      end
    end
  end
end
