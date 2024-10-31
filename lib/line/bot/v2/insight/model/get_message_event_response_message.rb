# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Insight
        class GetMessageEventResponseMessage
          attr_accessor :seq # Bubble's serial number.
          attr_accessor :impression # Number of times the bubble was displayed.
          attr_accessor :media_played # Number of times audio or video in the bubble started playing.
          attr_accessor :media_played25_percent # Number of times audio or video in the bubble started playing and was played 25% of the total time.
          attr_accessor :media_played50_percent # Number of times audio or video in the bubble started playing and was played 50% of the total time.
          attr_accessor :media_played75_percent # Number of times audio or video in the bubble started playing and was played 75% of the total time.
          attr_accessor :media_played100_percent # Number of times audio or video in the bubble started playing and was played 100% of the total time.
          attr_accessor :unique_media_played # Number of users that started playing audio or video in the bubble.
          attr_accessor :unique_media_played25_percent # Number of users that started playing audio or video in the bubble and played 25% of the total time.
          attr_accessor :unique_media_played50_percent # Number of users that started playing audio or video in the bubble and played 50% of the total time.
          attr_accessor :unique_media_played75_percent # Number of users that started playing audio or video in the bubble and played 75% of the total time.
          attr_accessor :unique_media_played100_percent # Number of users that started playing audio or video in the bubble and played 100% of the total time.

          def initialize(
            seq: nil,
            impression: nil,
            media_played: nil,
            media_played25_percent: nil,
            media_played50_percent: nil,
            media_played75_percent: nil,
            media_played100_percent: nil,
            unique_media_played: nil,
            unique_media_played25_percent: nil,
            unique_media_played50_percent: nil,
            unique_media_played75_percent: nil,
            unique_media_played100_percent: nil
          )
            @seq = seq
            @impression = impression
            @media_played = media_played
            @media_played25_percent = media_played25_percent
            @media_played50_percent = media_played50_percent
            @media_played75_percent = media_played75_percent
            @media_played100_percent = media_played100_percent
            @unique_media_played = unique_media_played
            @unique_media_played25_percent = unique_media_played25_percent
            @unique_media_played50_percent = unique_media_played50_percent
            @unique_media_played75_percent = unique_media_played75_percent
            @unique_media_played100_percent = unique_media_played100_percent
          end
        end
      end
    end
  end
end
