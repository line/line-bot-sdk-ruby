# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './module_content'

module Line
  module Bot
    module V2
      module Webhook
        class DetachedModuleContent < ModuleContent
          attr_reader :type # Type
          attr_accessor :bot_id # Detached LINE Official Account bot user ID
          attr_accessor :reason # Reason for detaching

          def initialize(
            type:,
            bot_id:,
            reason:
          )
            @type = "detached"
            
            @bot_id = bot_id
            @reason = reason
          end
        end
      end
    end
  end
end
