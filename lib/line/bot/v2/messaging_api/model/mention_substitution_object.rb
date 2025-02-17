# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './substitution_object'

# An object representing a mention substitution.
# @see https://developers.line.biz/en/reference/messaging-api/#text-message-v2-mention-object
module Line
  module Bot
    module V2
      module MessagingApi
        class MentionSubstitutionObject < SubstitutionObject
          attr_reader :type # Type of substitution object
          attr_accessor :mentionee

          def initialize(
            mentionee:
          )
            @type = "mention"
            
            @mentionee = mentionee
          end
        end
      end
    end
  end
end
