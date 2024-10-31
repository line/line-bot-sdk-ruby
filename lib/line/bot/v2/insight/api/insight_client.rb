# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
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
      module Insight
        class ApiClient
          def initialize(base_url: nil, channel_access_token:, http_options: {})
            @http_client = HttpClient.new(
              base_url: base_url || 'https://api.line.me',
              http_headers: {
                Authorization: "Bearer #{channel_access_token}"
              },
              http_options: http_options
            )
          end

          # Retrieves the demographic attributes for a LINE Official Account's friends.You can only retrieve information about friends for LINE Official Accounts created by users in Japan (JP), Thailand (TH), Taiwan (TW) and Indonesia (ID). 
          #
          # @see https://developers.line.biz/en/reference/messaging-api/#get-demographic
          def get_friends_demographics_with_http_info(
          )
            path = "/v2/bot/insight/demographic"

            response = @http_client.get(
              path: path,
            )

            body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::Insight::GetFriendsDemographicsResponse.new(**json)
                   else
                     response.body
                   end

            [body, response.code.to_i, response.each_header.to_h]
          end

          # Retrieves the demographic attributes for a LINE Official Account's friends.You can only retrieve information about friends for LINE Official Accounts created by users in Japan (JP), Thailand (TH), Taiwan (TW) and Indonesia (ID). 
          #
          # @see https://developers.line.biz/en/reference/messaging-api/#get-demographic
          def get_friends_demographics(
          )
            body, _status_code, _headers = get_friends_demographics_with_http_info(
            )

            body
          end

          # Returns statistics about how users interact with narrowcast messages or broadcast messages sent from your LINE Official Account. 
          #
          # @summary Get user interaction statistics
          # @param request_id Request ID of a narrowcast message or broadcast message. Each Messaging API request has a request ID. 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-message-event
          def get_message_event_with_http_info(
            request_id:
          )
            path = "/v2/bot/insight/message/event"
            query_params = {
              "requestId": request_id
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::Insight::GetMessageEventResponse.new(**json)
                   else
                     response.body
                   end

            [body, response.code.to_i, response.each_header.to_h]
          end

          # Returns statistics about how users interact with narrowcast messages or broadcast messages sent from your LINE Official Account. 
          #
          # @summary Get user interaction statistics
          # @param request_id Request ID of a narrowcast message or broadcast message. Each Messaging API request has a request ID. 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-message-event
          def get_message_event(
            request_id:
          )
            body, _status_code, _headers = get_message_event_with_http_info(
              request_id: request_id
            )

            body
          end

          # Returns the number of users who have added the LINE Official Account on or before a specified date. 
          #
          # @summary Get number of followers
          # @param date Date for which to retrieve the number of followers.  Format: yyyyMMdd (e.g. 20191231) Timezone: UTC+9 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-followers
          def get_number_of_followers_with_http_info(
            date: nil
          )
            path = "/v2/bot/insight/followers"
            query_params = {
              "date": date
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::Insight::GetNumberOfFollowersResponse.new(**json)
                   else
                     response.body
                   end

            [body, response.code.to_i, response.each_header.to_h]
          end

          # Returns the number of users who have added the LINE Official Account on or before a specified date. 
          #
          # @summary Get number of followers
          # @param date Date for which to retrieve the number of followers.  Format: yyyyMMdd (e.g. 20191231) Timezone: UTC+9 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-followers
          def get_number_of_followers(
            date: nil
          )
            body, _status_code, _headers = get_number_of_followers_with_http_info(
              date: date
            )

            body
          end

          # Returns the number of messages sent from LINE Official Account on a specified day. 
          #
          # @summary Get number of message deliveries
          # @param date Date for which to retrieve number of sent messages. - Format: yyyyMMdd (e.g. 20191231) - Timezone: UTC+9 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-delivery-messages
          def get_number_of_message_deliveries_with_http_info(
            date:
          )
            path = "/v2/bot/insight/message/delivery"
            query_params = {
              "date": date
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::Insight::GetNumberOfMessageDeliveriesResponse.new(**json)
                   else
                     response.body
                   end

            [body, response.code.to_i, response.each_header.to_h]
          end

          # Returns the number of messages sent from LINE Official Account on a specified day. 
          #
          # @summary Get number of message deliveries
          # @param date Date for which to retrieve number of sent messages. - Format: yyyyMMdd (e.g. 20191231) - Timezone: UTC+9 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-delivery-messages
          def get_number_of_message_deliveries(
            date:
          )
            body, _status_code, _headers = get_number_of_message_deliveries_with_http_info(
              date: date
            )

            body
          end

          # You can check the per-unit statistics of how users interact with push messages and multicast messages sent from your LINE Official Account. 
          #
          # @param custom_aggregation_unit Name of aggregation unit specified when sending the message. Case-sensitive. For example, `Promotion_a` and `Promotion_A` are regarded as different unit names. 
          # @param from Start date of aggregation period.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9 
          # @param to End date of aggregation period. The end date can be specified for up to 30 days later. For example, if the start date is 20210301, the latest end date is 20210331.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-statistics-per-unit
          def get_statistics_per_unit_with_http_info(
            custom_aggregation_unit:,
            from:,
            to:
          )
            path = "/v2/bot/insight/message/event/aggregation"
            query_params = {
              "customAggregationUnit": custom_aggregation_unit,
              "from": from,
              "to": to
            }.compact

            response = @http_client.get(
              path: path,
              query_params: query_params,
            )

            body = case response.code.to_i
                   when 200
                     json = Line::Bot::V2::Utils.deep_underscore(JSON.parse(response.body))
                     json.transform_keys! do |key|
                       Line::Bot::V2::RESERVED_WORDS.include?(key) ? "_#{key}".to_sym : key
                     end
                     Line::Bot::V2::Insight::GetStatisticsPerUnitResponse.new(**json)
                   else
                     response.body
                   end

            [body, response.code.to_i, response.each_header.to_h]
          end

          # You can check the per-unit statistics of how users interact with push messages and multicast messages sent from your LINE Official Account. 
          #
          # @param custom_aggregation_unit Name of aggregation unit specified when sending the message. Case-sensitive. For example, `Promotion_a` and `Promotion_A` are regarded as different unit names. 
          # @param from Start date of aggregation period.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9 
          # @param to End date of aggregation period. The end date can be specified for up to 30 days later. For example, if the start date is 20210301, the latest end date is 20210331.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9 
          # @see https://developers.line.biz/en/reference/messaging-api/#get-statistics-per-unit
          def get_statistics_per_unit(
            custom_aggregation_unit:,
            from:,
            to:
          )
            body, _status_code, _headers = get_statistics_per_unit_with_http_info(
              custom_aggregation_unit: custom_aggregation_unit,
              from: from,
              to: to
            )

            body
          end
        end
      end
    end
  end
end
