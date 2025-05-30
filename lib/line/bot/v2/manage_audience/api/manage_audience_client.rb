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
      module ManageAudience
        class ApiClient
          # Initializes a new {Line::Bot::V2::ManageAudience::ApiClient} instance.
          #
          # @param base_url [String] The base URL for requests (optional).
          #   Defaults to 'https://api.line.me' if none is provided.
          #   You can override this for testing or to use a mock server.
          # @param channel_access_token [String] The channel access token for authorization.
          # @param http_options [Hash] HTTP options (same as Net::HTTP options).
          #   See: https://docs.ruby-lang.org/en/3.4/Net/HTTP.html to understand the options.
          #
          # @example
          #   @client ||= Line::Bot::V2::ManageAudience::ApiClient.new(
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

          # Add user IDs or Identifiers for Advertisers (IFAs) to an audience for uploading user IDs (by JSON)
          # This requests to <code>PUT https://api.line.me/v2/bot/audienceGroup/upload</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param add_audience_to_audience_group_request [AddAudienceToAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#update-upload-audience-group
          # @return [Array((String|nil), Integer, Hash{String => String})] when HTTP status code is 202
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def add_audience_to_audience_group_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            add_audience_to_audience_group_request:
          )
            path = "/v2/bot/audienceGroup/upload"

            response = @http_client.put(
              path: path,
              body_params: add_audience_to_audience_group_request,
            )

            case response.code.to_i
            when 202
              [response.body, 202, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Add user IDs or Identifiers for Advertisers (IFAs) to an audience for uploading user IDs (by JSON)
          # This requests to <code>PUT https://api.line.me/v2/bot/audienceGroup/upload</code>
          # When you want to get HTTP status code or response headers, use {#add_audience_to_audience_group_with_http_info} instead of this.
          #
          # @param add_audience_to_audience_group_request [AddAudienceToAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#update-upload-audience-group
          # @return [String, nil] when HTTP status code is 202
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def add_audience_to_audience_group(
            add_audience_to_audience_group_request:
          )
            response_body, _status_code, _headers = add_audience_to_audience_group_with_http_info(
              add_audience_to_audience_group_request: add_audience_to_audience_group_request
            )

            response_body
          end

          # Create audience for uploading user IDs (by JSON)
          # This requests to <code>POST https://api.line.me/v2/bot/audienceGroup/upload</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param create_audience_group_request [CreateAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-upload-audience-group
          # @return [Array(Line::Bot::V2::ManageAudience::CreateAudienceGroupResponse, Integer, Hash{String => String})] when HTTP status code is 202
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def create_audience_group_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            create_audience_group_request:
          )
            path = "/v2/bot/audienceGroup/upload"

            response = @http_client.post(
              path: path,
              body_params: create_audience_group_request,
            )

            case response.code.to_i
            when 202
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::CreateAudienceGroupResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 202, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Create audience for uploading user IDs (by JSON)
          # This requests to <code>POST https://api.line.me/v2/bot/audienceGroup/upload</code>
          # When you want to get HTTP status code or response headers, use {#create_audience_group_with_http_info} instead of this.
          #
          # @param create_audience_group_request [CreateAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-upload-audience-group
          # @return [Line::Bot::V2::ManageAudience::CreateAudienceGroupResponse] when HTTP status code is 202
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def create_audience_group(
            create_audience_group_request:
          )
            response_body, _status_code, _headers = create_audience_group_with_http_info(
              create_audience_group_request: create_audience_group_request
            )

            response_body
          end

          # Create audience for click-based retargeting
          # This requests to <code>POST https://api.line.me/v2/bot/audienceGroup/click</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param create_click_based_audience_group_request [CreateClickBasedAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-click-audience-group
          # @return [Array(Line::Bot::V2::ManageAudience::CreateClickBasedAudienceGroupResponse, Integer, Hash{String => String})] when HTTP status code is 202
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def create_click_based_audience_group_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            create_click_based_audience_group_request:
          )
            path = "/v2/bot/audienceGroup/click"

            response = @http_client.post(
              path: path,
              body_params: create_click_based_audience_group_request,
            )

            case response.code.to_i
            when 202
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::CreateClickBasedAudienceGroupResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 202, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Create audience for click-based retargeting
          # This requests to <code>POST https://api.line.me/v2/bot/audienceGroup/click</code>
          # When you want to get HTTP status code or response headers, use {#create_click_based_audience_group_with_http_info} instead of this.
          #
          # @param create_click_based_audience_group_request [CreateClickBasedAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-click-audience-group
          # @return [Line::Bot::V2::ManageAudience::CreateClickBasedAudienceGroupResponse] when HTTP status code is 202
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def create_click_based_audience_group(
            create_click_based_audience_group_request:
          )
            response_body, _status_code, _headers = create_click_based_audience_group_with_http_info(
              create_click_based_audience_group_request: create_click_based_audience_group_request
            )

            response_body
          end

          # Create audience for impression-based retargeting
          # This requests to <code>POST https://api.line.me/v2/bot/audienceGroup/imp</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param create_imp_based_audience_group_request [CreateImpBasedAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-imp-audience-group
          # @return [Array(Line::Bot::V2::ManageAudience::CreateImpBasedAudienceGroupResponse, Integer, Hash{String => String})] when HTTP status code is 202
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def create_imp_based_audience_group_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            create_imp_based_audience_group_request:
          )
            path = "/v2/bot/audienceGroup/imp"

            response = @http_client.post(
              path: path,
              body_params: create_imp_based_audience_group_request,
            )

            case response.code.to_i
            when 202
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::CreateImpBasedAudienceGroupResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 202, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Create audience for impression-based retargeting
          # This requests to <code>POST https://api.line.me/v2/bot/audienceGroup/imp</code>
          # When you want to get HTTP status code or response headers, use {#create_imp_based_audience_group_with_http_info} instead of this.
          #
          # @param create_imp_based_audience_group_request [CreateImpBasedAudienceGroupRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#create-imp-audience-group
          # @return [Line::Bot::V2::ManageAudience::CreateImpBasedAudienceGroupResponse] when HTTP status code is 202
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def create_imp_based_audience_group(
            create_imp_based_audience_group_request:
          )
            response_body, _status_code, _headers = create_imp_based_audience_group_with_http_info(
              create_imp_based_audience_group_request: create_imp_based_audience_group_request
            )

            response_body
          end

          # Delete audience
          # This requests to <code>DELETE https://api.line.me/v2/bot/audienceGroup/{audienceGroupId}</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @see https://developers.line.biz/en/reference/messaging-api/#delete-audience-group
          # @return [Array((String|nil), Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def delete_audience_group_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            audience_group_id:
          )
            path = "/v2/bot/audienceGroup/{audienceGroupId}"
              .gsub(/{audienceGroupId}/, audience_group_id.to_s)

            response = @http_client.delete(
              path: path,
            )

            case response.code.to_i
            when 200
              [response.body, 200, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Delete audience
          # This requests to <code>DELETE https://api.line.me/v2/bot/audienceGroup/{audienceGroupId}</code>
          # When you want to get HTTP status code or response headers, use {#delete_audience_group_with_http_info} instead of this.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @see https://developers.line.biz/en/reference/messaging-api/#delete-audience-group
          # @return [String, nil] when HTTP status code is 200
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def delete_audience_group(
            audience_group_id:
          )
            response_body, _status_code, _headers = delete_audience_group_with_http_info(
              audience_group_id: audience_group_id
            )

            response_body
          end

          # Gets audience data.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/{audienceGroupId}</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @see https://developers.line.biz/en/reference/messaging-api/#get-audience-group
          # @return [Array(Line::Bot::V2::ManageAudience::GetAudienceDataResponse, Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array(Line::Bot::V2::ManageAudience::ErrorResponse, Integer, Hash{String => String})] when HTTP status code is 400
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def get_audience_data_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            audience_group_id:
          )
            path = "/v2/bot/audienceGroup/{audienceGroupId}"
              .gsub(/{audienceGroupId}/, audience_group_id.to_s)

            response = @http_client.get(
              path: path,
            )

            case response.code.to_i
            when 200
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::GetAudienceDataResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 200, response.each_header.to_h]
            when 400
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::ErrorResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 400, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Gets audience data.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/{audienceGroupId}</code>
          # When you want to get HTTP status code or response headers, use {#get_audience_data_with_http_info} instead of this.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @see https://developers.line.biz/en/reference/messaging-api/#get-audience-group
          # @return [Line::Bot::V2::ManageAudience::GetAudienceDataResponse] when HTTP status code is 200
          # @return [Line::Bot::V2::ManageAudience::ErrorResponse] when HTTP status code is 400
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def get_audience_data(
            audience_group_id:
          )
            response_body, _status_code, _headers = get_audience_data_with_http_info(
              audience_group_id: audience_group_id
            )

            response_body
          end

          # Gets data for more than one audience.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/list</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param page [Integer] The page to return when getting (paginated) results. Must be 1 or higher.
          # @param description [String, nil] The name of the audience(s) to return. You can search for partial matches. This is case-insensitive, meaning AUDIENCE and audience are considered identical. If omitted, the name of the audience(s) will not be used as a search criterion. 
          # @param status [AudienceGroupStatus, nil] The status of the audience(s) to return. If omitted, the status of the audience(s) will not be used as a search criterion. 
          # @param size [Integer, nil] The number of audiences per page. Default: 20 Max: 40 
          # @param includes_external_public_groups [Boolean, nil] true (default): Get public audiences created in all channels linked to the same bot. false: Get audiences created in the same channel. 
          # @param create_route [AudienceGroupCreateRoute, nil] How the audience was created. If omitted, all audiences are included.  `OA_MANAGER`: Return only audiences created with LINE Official Account Manager (opens new window). `MESSAGING_API`: Return only audiences created with Messaging API. 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-audience-groups
          # @return [Array(Line::Bot::V2::ManageAudience::GetAudienceGroupsResponse, Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def get_audience_groups_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            page:, 
            description: nil, 
            status: nil, 
            size: nil, 
            includes_external_public_groups: nil, 
            create_route: nil
          )
            path = "/v2/bot/audienceGroup/list"
            query_params = {
              "page": page,
              "description": description,
              "status": status,
              "size": size,
              "includesExternalPublicGroups": includes_external_public_groups,
              "createRoute": create_route
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            case response.code.to_i
            when 200
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::GetAudienceGroupsResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 200, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Gets data for more than one audience.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/list</code>
          # When you want to get HTTP status code or response headers, use {#get_audience_groups_with_http_info} instead of this.
          #
          # @param page [Integer] The page to return when getting (paginated) results. Must be 1 or higher.
          # @param description [String, nil] The name of the audience(s) to return. You can search for partial matches. This is case-insensitive, meaning AUDIENCE and audience are considered identical. If omitted, the name of the audience(s) will not be used as a search criterion. 
          # @param status [AudienceGroupStatus, nil] The status of the audience(s) to return. If omitted, the status of the audience(s) will not be used as a search criterion. 
          # @param size [Integer, nil] The number of audiences per page. Default: 20 Max: 40 
          # @param includes_external_public_groups [Boolean, nil] true (default): Get public audiences created in all channels linked to the same bot. false: Get audiences created in the same channel. 
          # @param create_route [AudienceGroupCreateRoute, nil] How the audience was created. If omitted, all audiences are included.  `OA_MANAGER`: Return only audiences created with LINE Official Account Manager (opens new window). `MESSAGING_API`: Return only audiences created with Messaging API. 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-audience-groups
          # @return [Line::Bot::V2::ManageAudience::GetAudienceGroupsResponse] when HTTP status code is 200
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def get_audience_groups(
            page:,
            description: nil,
            status: nil,
            size: nil,
            includes_external_public_groups: nil,
            create_route: nil
          )
            response_body, _status_code, _headers = get_audience_groups_with_http_info(
              page: page,
              description: description,
              status: status,
              size: size,
              includes_external_public_groups: includes_external_public_groups,
              create_route: create_route
            )

            response_body
          end

          # Gets audience data.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/shared/{audienceGroupId}</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @see https://developers.line.biz/en/reference/messaging-api/#get-shared-audience
          # @return [Array(Line::Bot::V2::ManageAudience::GetSharedAudienceDataResponse, Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array(Line::Bot::V2::ManageAudience::ErrorResponse, Integer, Hash{String => String})] when HTTP status code is 400
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def get_shared_audience_data_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            audience_group_id:
          )
            path = "/v2/bot/audienceGroup/shared/{audienceGroupId}"
              .gsub(/{audienceGroupId}/, audience_group_id.to_s)

            response = @http_client.get(
              path: path,
            )

            case response.code.to_i
            when 200
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::GetSharedAudienceDataResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 200, response.each_header.to_h]
            when 400
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::ErrorResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 400, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Gets audience data.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/shared/{audienceGroupId}</code>
          # When you want to get HTTP status code or response headers, use {#get_shared_audience_data_with_http_info} instead of this.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @see https://developers.line.biz/en/reference/messaging-api/#get-shared-audience
          # @return [Line::Bot::V2::ManageAudience::GetSharedAudienceDataResponse] when HTTP status code is 200
          # @return [Line::Bot::V2::ManageAudience::ErrorResponse] when HTTP status code is 400
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def get_shared_audience_data(
            audience_group_id:
          )
            response_body, _status_code, _headers = get_shared_audience_data_with_http_info(
              audience_group_id: audience_group_id
            )

            response_body
          end

          # Gets data for more than one audience, including those shared by the Business Manager.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/shared/list</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param page [Integer] The page to return when getting (paginated) results. Must be 1 or higher.
          # @param description [String, nil] The name of the audience(s) to return. You can search for partial matches. This is case-insensitive, meaning AUDIENCE and audience are considered identical. If omitted, the name of the audience(s) will not be used as a search criterion. 
          # @param status [AudienceGroupStatus, nil] The status of the audience(s) to return. If omitted, the status of the audience(s) will not be used as a search criterion. 
          # @param size [Integer, nil] The number of audiences per page. Default: 20 Max: 40 
          # @param create_route [AudienceGroupCreateRoute, nil] How the audience was created. If omitted, all audiences are included.  `OA_MANAGER`: Return only audiences created with LINE Official Account Manager (opens new window). `MESSAGING_API`: Return only audiences created with Messaging API. 
          # @param includes_owned_audience_groups [Boolean, nil] true: Include audienceGroups owned by LINE Official Account Manager false: Respond only audienceGroups shared by Business Manager 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-shared-audience-list
          # @return [Array(Line::Bot::V2::ManageAudience::GetSharedAudienceGroupsResponse, Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def get_shared_audience_groups_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            page:, 
            description: nil, 
            status: nil, 
            size: nil, 
            create_route: nil, 
            includes_owned_audience_groups: nil
          )
            path = "/v2/bot/audienceGroup/shared/list"
            query_params = {
              "page": page,
              "description": description,
              "status": status,
              "size": size,
              "createRoute": create_route,
              "includesOwnedAudienceGroups": includes_owned_audience_groups
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            case response.code.to_i
            when 200
              json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
              json.transform_keys! do |key|
                Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
              end
              response_body = Line::Bot::V2::ManageAudience::GetSharedAudienceGroupsResponse.create(json) # steep:ignore InsufficientKeywordArguments
              [response_body, 200, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Gets data for more than one audience, including those shared by the Business Manager.
          # This requests to <code>GET https://api.line.me/v2/bot/audienceGroup/shared/list</code>
          # When you want to get HTTP status code or response headers, use {#get_shared_audience_groups_with_http_info} instead of this.
          #
          # @param page [Integer] The page to return when getting (paginated) results. Must be 1 or higher.
          # @param description [String, nil] The name of the audience(s) to return. You can search for partial matches. This is case-insensitive, meaning AUDIENCE and audience are considered identical. If omitted, the name of the audience(s) will not be used as a search criterion. 
          # @param status [AudienceGroupStatus, nil] The status of the audience(s) to return. If omitted, the status of the audience(s) will not be used as a search criterion. 
          # @param size [Integer, nil] The number of audiences per page. Default: 20 Max: 40 
          # @param create_route [AudienceGroupCreateRoute, nil] How the audience was created. If omitted, all audiences are included.  `OA_MANAGER`: Return only audiences created with LINE Official Account Manager (opens new window). `MESSAGING_API`: Return only audiences created with Messaging API. 
          # @param includes_owned_audience_groups [Boolean, nil] true: Include audienceGroups owned by LINE Official Account Manager false: Respond only audienceGroups shared by Business Manager 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-shared-audience-list
          # @return [Line::Bot::V2::ManageAudience::GetSharedAudienceGroupsResponse] when HTTP status code is 200
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def get_shared_audience_groups(
            page:,
            description: nil,
            status: nil,
            size: nil,
            create_route: nil,
            includes_owned_audience_groups: nil
          )
            response_body, _status_code, _headers = get_shared_audience_groups_with_http_info(
              page: page,
              description: description,
              status: status,
              size: size,
              create_route: create_route,
              includes_owned_audience_groups: includes_owned_audience_groups
            )

            response_body
          end

          # Renames an existing audience.
          # This requests to <code>PUT https://api.line.me/v2/bot/audienceGroup/{audienceGroupId}/updateDescription</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @param update_audience_group_description_request [UpdateAudienceGroupDescriptionRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#set-description-audience-group
          # @return [Array((String|nil), Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def update_audience_group_description_with_http_info( # steep:ignore MethodBodyTypeMismatch 
            audience_group_id:, 
            update_audience_group_description_request:
          )
            path = "/v2/bot/audienceGroup/{audienceGroupId}/updateDescription"
              .gsub(/{audienceGroupId}/, audience_group_id.to_s)

            response = @http_client.put(
              path: path,
              body_params: update_audience_group_description_request,
            )

            case response.code.to_i
            when 200
              [response.body, 200, response.each_header.to_h]
            else
              [response.body, response.code.to_i, response.each_header.to_h]
            end
          end

          # Renames an existing audience.
          # This requests to <code>PUT https://api.line.me/v2/bot/audienceGroup/{audienceGroupId}/updateDescription</code>
          # When you want to get HTTP status code or response headers, use {#update_audience_group_description_with_http_info} instead of this.
          #
          # @param audience_group_id [Integer] The audience ID.
          # @param update_audience_group_description_request [UpdateAudienceGroupDescriptionRequest] 
          # @see https://developers.line.biz/en/reference/messaging-api/#set-description-audience-group
          # @return [String, nil] when HTTP status code is 200
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def update_audience_group_description(
            audience_group_id:,
            update_audience_group_description_request:
          )
            response_body, _status_code, _headers = update_audience_group_description_with_http_info(
              audience_group_id: audience_group_id,
              update_audience_group_description_request: update_audience_group_description_request
            )

            response_body
          end
        end
      end
    end
  end
end
