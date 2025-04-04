# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require 'json'

require 'line/bot/v2/http_client'
require 'line/bot/v2/reserved_words'
require 'line/bot/v2/utils'

module Line
  module Bot
    module V2
      module Module
        class ApiClient
          # Initializes a new {Line::Bot::V2::Module::ApiClient} instance.
          #
          # @param base_url [String] The base URL for requests (optional).
          #   Defaults to 'https://api.line.me' if none is provided.
          #   You can override this for testing or to use a mock server.
          # @param channel_access_token [String] The channel access token for authorization.
          # @param http_options [Hash] HTTP options (same as Net::HTTP options).
          #   See: https://docs.ruby-lang.org/en/3.4/Net/HTTP.html to understand the options.
          #
          # @example
          #   @client ||= Line::Bot::V2::Module::ApiClient.new(
          #     channel_access_token: "YOUR_CHANNEL_ACCESS_TOKEN",
          #     http_options: {
          #       open_timeout: 5,
          #       read_timeout: 5,
          #     }
          #   )
          def initialize(base_url: nil, channel_access_token:, http_options: {})
            @http_client = HttpClient.new(
              base_url: base_url || 'https://api.line.me',
              http_headers: {
                Authorization: "Bearer #{channel_access_token}"
              },
              http_options: http_options
            )
          end

          # If the Standby Channel wants to take the initiative (Chat Control), it calls the Acquire Control API. The channel that was previously an Active Channel will automatically switch to a Standby Channel. 
          #
          # @param chat_id The `userId`, `roomId`, or `groupId`
          # @param acquire_chat_control_request 
          # @see https://developers.line.biz/en/reference/partner-docs/#acquire-control-api
          def acquire_chat_control_with_http_info(
            chat_id:,
            acquire_chat_control_request: nil
          )
            path = "/v2/bot/chat/{chatId}/control/acquire"
              .gsub(/{chatId}/, chat_id)

            response = @http_client.post(
              path: path,
              body_params: acquire_chat_control_request,
            )

            response_body = case response.code.to_i
                   when 200
                     response.body
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # If the Standby Channel wants to take the initiative (Chat Control), it calls the Acquire Control API. The channel that was previously an Active Channel will automatically switch to a Standby Channel. 
          #
          # @param chat_id The `userId`, `roomId`, or `groupId`
          # @param acquire_chat_control_request 
          # @see https://developers.line.biz/en/reference/partner-docs/#acquire-control-api
          def acquire_chat_control(
            chat_id:,
            acquire_chat_control_request: nil
          )
            response_body, _status_code, _headers = acquire_chat_control_with_http_info(
              chat_id: chat_id,
              acquire_chat_control_request: acquire_chat_control_request
            )

            response_body
          end

          # The module channel admin calls the Detach API to detach the module channel from a LINE Official Account.
          #
          # @param detach_module_request 
          # @see https://developers.line.biz/en/reference/partner-docs/#unlink-detach-module-channel-by-operation-mc-admin
          def detach_module_with_http_info(
            detach_module_request: nil
          )
            path = "/v2/bot/channel/detach"

            response = @http_client.post(
              path: path,
              body_params: detach_module_request,
            )

            response_body = case response.code.to_i
                   when 200
                     response.body
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # The module channel admin calls the Detach API to detach the module channel from a LINE Official Account.
          #
          # @param detach_module_request 
          # @see https://developers.line.biz/en/reference/partner-docs/#unlink-detach-module-channel-by-operation-mc-admin
          def detach_module(
            detach_module_request: nil
          )
            response_body, _status_code, _headers = detach_module_with_http_info(
              detach_module_request: detach_module_request
            )

            response_body
          end

          # Gets a list of basic information about the bots of multiple LINE Official Accounts that have attached module channels.
          #
          # @param start Value of the continuation token found in the next property of the JSON object returned in the response. If you can't get all basic information about the bots in one request, include this parameter to get the remaining array. 
          # @param limit Specify the maximum number of bots that you get basic information from. The default value is 100. Max value: 100 
          # @see https://developers.line.biz/en/reference/partner-docs/#get-multiple-bot-info-api
          def get_modules_with_http_info(
            start: nil,
            limit: nil
          )
            path = "/v2/bot/list"
            query_params = {
              "start": start,
              "limit": limit
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            response_body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::Module::GetModulesResponse.new(**json)
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # Gets a list of basic information about the bots of multiple LINE Official Accounts that have attached module channels.
          #
          # @param start Value of the continuation token found in the next property of the JSON object returned in the response. If you can't get all basic information about the bots in one request, include this parameter to get the remaining array. 
          # @param limit Specify the maximum number of bots that you get basic information from. The default value is 100. Max value: 100 
          # @see https://developers.line.biz/en/reference/partner-docs/#get-multiple-bot-info-api
          def get_modules(
            start: nil,
            limit: nil
          )
            response_body, _status_code, _headers = get_modules_with_http_info(
              start: start,
              limit: limit
            )

            response_body
          end

          # To return the initiative (Chat Control) of Active Channel to Primary Channel, call the Release Control API. 
          #
          # @param chat_id The `userId`, `roomId`, or `groupId`
          # @see https://developers.line.biz/en/reference/partner-docs/#release-control-api
          def release_chat_control_with_http_info(
            chat_id:
          )
            path = "/v2/bot/chat/{chatId}/control/release"
              .gsub(/{chatId}/, chat_id)

            response = @http_client.post(
              path: path,
            )

            response_body = case response.code.to_i
                   when 200
                     response.body
                   else
                     response.body
                   end

            [response_body, response.code.to_i, response.each_header.to_h]
          end

          # To return the initiative (Chat Control) of Active Channel to Primary Channel, call the Release Control API. 
          #
          # @param chat_id The `userId`, `roomId`, or `groupId`
          # @see https://developers.line.biz/en/reference/partner-docs/#release-control-api
          def release_chat_control(
            chat_id:
          )
            response_body, _status_code, _headers = release_chat_control_with_http_info(
              chat_id: chat_id
            )

            response_body
          end
        end
      end
    end
  end
end
