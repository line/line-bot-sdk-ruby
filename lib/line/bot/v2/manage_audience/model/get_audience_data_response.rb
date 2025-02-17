# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Get audience data
# @see https://developers.line.biz/en/reference/messaging-api/#get-audience-group
module Line
  module Bot
    module V2
      module ManageAudience
        class GetAudienceDataResponse
          attr_accessor :audience_group
          attr_accessor :jobs # An array of jobs. This array is used to keep track of each attempt to add new user IDs or IFAs to an audience for uploading user IDs. Empty array is returned for any other type of audience. Max: 50 

          def initialize(
            audience_group: nil,
            jobs: nil
          )
            
            @audience_group = audience_group
            @jobs = jobs
          end
        end
      end
    end
  end
end
