# LIFF server API
# LIFF Server API.
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Liff
        # @see https://developers.line.biz/en/reference/liff-server/#add-liff-app
        class AddLiffAppRequest
          attr_accessor :view
          attr_accessor :description # Name of the LIFF app.  The LIFF app name can't include \"LINE\" or similar strings, or inappropriate strings. 
          attr_accessor :features
          attr_accessor :permanent_link_pattern # How additional information in LIFF URLs is handled. Specify `concat`. 
          attr_accessor :scope
          attr_accessor :bot_prompt

          def initialize(
            view:,
            description: nil,
            features: nil,
            permanent_link_pattern: nil,
            scope: nil,
            bot_prompt: nil
          )
            
            @view = view
            @description = description
            @features = features
            @permanent_link_pattern = permanent_link_pattern
            @scope = scope
            @bot_prompt = bot_prompt
          end
        end
      end
    end
  end
end
