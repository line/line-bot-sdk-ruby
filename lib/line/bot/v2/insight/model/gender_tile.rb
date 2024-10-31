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
        class GenderTile
          attr_accessor :gender # users' gender
          attr_accessor :percentage # Percentage

          def initialize(
            gender: nil,
            percentage: nil
          )
            @gender = gender
            @percentage = percentage
          end
        end
      end
    end
  end
end
