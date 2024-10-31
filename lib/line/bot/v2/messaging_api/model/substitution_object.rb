# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# An object that defines the replacement value for a placeholder in the text.
module Line
  module Bot
    module V2
      module MessagingApi
        class SubstitutionObject
          attr_accessor :type # Type of substitution object

          def initialize(
            type:
          )
            @type = type
          end
        end
      end
    end
  end
end
