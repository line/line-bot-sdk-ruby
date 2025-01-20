# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './recipient'

module Line
  module Bot
    module V2
      module MessagingApi
        class AudienceRecipient < Recipient
          attr_reader :type # Type of recipient
          attr_accessor :audience_group_id

          def initialize(
            audience_group_id: nil
          )
            @type = "audience"
            
            @audience_group_id = audience_group_id
          end
        end
      end
    end
  end
end
