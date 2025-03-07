# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# List of bots to which the module is attached
# @see https://developers.line.biz/en/reference/partner-docs/#get-multiple-bot-info-api
module Line
  module Bot
    module V2
      module Module
        class GetModulesResponse
          attr_accessor :bots # Array of Bot list Item objects representing basic information about the bot.
          attr_accessor :_next # Continuation token. Used to get the next array of basic bot information. This property is only returned if there are more unreturned results. 

          def initialize(
            bots:,
            _next: nil
          )
            
            @bots = bots
            @_next = _next
          end
        end
      end
    end
  end
end
