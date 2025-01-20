# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './demographic_filter'

module Line
  module Bot
    module V2
      module MessagingApi
        class AreaDemographicFilter < DemographicFilter
          attr_reader :type # Type of demographic filter
          attr_accessor :one_of

          def initialize(
            one_of: nil
          )
            @type = "area"
            
            @one_of = one_of
          end
        end
      end
    end
  end
end
