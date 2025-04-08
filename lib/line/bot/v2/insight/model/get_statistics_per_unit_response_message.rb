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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-statistics-per-unit-response
        class GetStatisticsPerUnitResponseMessage
          # @!attribute [rw] seq
          #   @return [Integer] Bubble's serial number.
          attr_accessor :seq
          # @!attribute [rw] impression
          #   @return [Integer,nil] Number of times the bubble was displayed.
          attr_accessor :impression
          # @!attribute [rw] media_played
          #   @return [Integer,nil] Number of times audio or video in the bubble started playing.
          attr_accessor :media_played
          # @!attribute [rw] media_played25_percent
          #   @return [Integer,nil] Number of times audio or video in the bubble started playing and was played 25% of the total time.
          attr_accessor :media_played25_percent
          # @!attribute [rw] media_played50_percent
          #   @return [Integer,nil] Number of times audio or video in the bubble started playing and was played 50% of the total time.
          attr_accessor :media_played50_percent
          # @!attribute [rw] media_played75_percent
          #   @return [Integer,nil] Number of times audio or video in the bubble started playing and was played 75% of the total time.
          attr_accessor :media_played75_percent
          # @!attribute [rw] media_played100_percent
          #   @return [Integer,nil] Number of times audio or video in the bubble started playing and was played 100% of the total time.
          attr_accessor :media_played100_percent
          # @!attribute [rw] unique_impression
          #   @return [Integer,nil] Number of users the bubble was displayed.
          attr_accessor :unique_impression
          # @!attribute [rw] unique_media_played
          #   @return [Integer,nil] Number of users that started playing audio or video in the bubble.
          attr_accessor :unique_media_played
          # @!attribute [rw] unique_media_played25_percent
          #   @return [Integer,nil] Number of users that started playing audio or video in the bubble and played 25% of the total time.
          attr_accessor :unique_media_played25_percent
          # @!attribute [rw] unique_media_played50_percent
          #   @return [Integer,nil] Number of users that started playing audio or video in the bubble and played 50% of the total time.
          attr_accessor :unique_media_played50_percent
          # @!attribute [rw] unique_media_played75_percent
          #   @return [Integer,nil] Number of users that started playing audio or video in the bubble and played 75% of the total time.
          attr_accessor :unique_media_played75_percent
          # @!attribute [rw] unique_media_played100_percent
          #   @return [Integer,nil] Number of users that started playing audio or video in the bubble and played 100% of the total time.
          attr_accessor :unique_media_played100_percent

          # @param seq [Integer] Bubble's serial number.
          # @param impression [Integer,nil] Number of times the bubble was displayed.
          # @param media_played [Integer,nil] Number of times audio or video in the bubble started playing.
          # @param media_played25_percent [Integer,nil] Number of times audio or video in the bubble started playing and was played 25% of the total time.
          # @param media_played50_percent [Integer,nil] Number of times audio or video in the bubble started playing and was played 50% of the total time.
          # @param media_played75_percent [Integer,nil] Number of times audio or video in the bubble started playing and was played 75% of the total time.
          # @param media_played100_percent [Integer,nil] Number of times audio or video in the bubble started playing and was played 100% of the total time.
          # @param unique_impression [Integer,nil] Number of users the bubble was displayed.
          # @param unique_media_played [Integer,nil] Number of users that started playing audio or video in the bubble.
          # @param unique_media_played25_percent [Integer,nil] Number of users that started playing audio or video in the bubble and played 25% of the total time.
          # @param unique_media_played50_percent [Integer,nil] Number of users that started playing audio or video in the bubble and played 50% of the total time.
          # @param unique_media_played75_percent [Integer,nil] Number of users that started playing audio or video in the bubble and played 75% of the total time.
          # @param unique_media_played100_percent [Integer,nil] Number of users that started playing audio or video in the bubble and played 100% of the total time.
          def initialize(
            seq:,
            impression: nil,
            media_played: nil,
            media_played25_percent: nil,
            media_played50_percent: nil,
            media_played75_percent: nil,
            media_played100_percent: nil,
            unique_impression: nil,
            unique_media_played: nil,
            unique_media_played25_percent: nil,
            unique_media_played50_percent: nil,
            unique_media_played75_percent: nil,
            unique_media_played100_percent: nil,
            **dynamic_attributes
          )
            
            @seq = seq
            @impression = impression
            @media_played = media_played
            @media_played25_percent = media_played25_percent
            @media_played50_percent = media_played50_percent
            @media_played75_percent = media_played75_percent
            @media_played100_percent = media_played100_percent
            @unique_impression = unique_impression
            @unique_media_played = unique_media_played
            @unique_media_played25_percent = unique_media_played25_percent
            @unique_media_played50_percent = unique_media_played50_percent
            @unique_media_played75_percent = unique_media_played75_percent
            @unique_media_played100_percent = unique_media_played100_percent

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key

              if value.is_a?(Hash)
                struct_klass = Struct.new(*value.keys.map(&:to_sym))
                struct_values = value.map { |_k, v| v.is_a?(Hash) ? Line::Bot::V2::Utils.hash_to_struct(v) : v }
                instance_variable_set("@#{key}", struct_klass.new(*struct_values))
              else
                instance_variable_set("@#{key}", value)
              end
            end
          end

          def self.create(args)
            return new(**args)
          end
        end
      end
    end
  end
end
