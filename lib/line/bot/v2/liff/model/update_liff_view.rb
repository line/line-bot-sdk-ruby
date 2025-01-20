# LIFF server API
# LIFF Server API.
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# @see https://developers.line.biz/en/reference/liff-server/#update-liff-app
module Line
  module Bot
    module V2
      module Liff
        class UpdateLiffView
          attr_accessor :type # Size of the LIFF app view. Specify one of these values: - compact - tall - full 
          attr_accessor :url # Endpoint URL. This is the URL of the web app that implements the LIFF app (e.g. https://example.com). Used when the LIFF app is launched using the LIFF URL. The URL scheme must be https. URL fragments (#URL-fragment) can't be specified. 
          attr_accessor :module_mode # `true` to use the LIFF app in modular mode. When in modular mode, the action button in the header is not displayed. 

          def initialize(
            type: nil,
            url: nil,
            module_mode: nil
          )
            
            @type = type
            @url = url
            @module_mode = module_mode
          end
        end
      end
    end
  end
end
