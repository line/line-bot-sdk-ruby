# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Statistics related to messages.
# @see https://developers.line.biz/en/reference/messaging-api/#get-statistics-per-unit-response
module Line
  module Bot
    module V2
      module Insight
        class GetStatisticsPerUnitResponseOverview
          attr_accessor :unique_impression # Number of users who opened the message, meaning they displayed at least 1 bubble.
          attr_accessor :unique_click # Number of users who opened any URL in the message.
          attr_accessor :unique_media_played # Number of users who started playing any video or audio in the message.
          attr_accessor :unique_media_played100_percent # Number of users who played the entirety of any video or audio in the message.

          def initialize(
            unique_impression: nil,
            unique_click: nil,
            unique_media_played: nil,
            unique_media_played100_percent: nil
          )
            @unique_impression = unique_impression
            @unique_click = unique_click
            @unique_media_played = unique_media_played
            @unique_media_played100_percent = unique_media_played100_percent
          end
        end
      end
    end
  end
end
