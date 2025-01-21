# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Transcoding response
# @see https://developers.line.biz/en/reference/messaging-api/#verify-video-or-audio-preparation-status
module Line
  module Bot
    module V2
      module MessagingApi
        class GetMessageContentTranscodingResponse
          attr_accessor :status # The preparation status. One of:  `processing`: Preparing to get content. `succeeded`: Ready to get the content. You can get the content sent by users. `failed`: Failed to prepare to get the content. 

          def initialize(
            status:
          )
            
            @status = status
          end
        end
      end
    end
  end
end
