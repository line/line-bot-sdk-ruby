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
        # Statistics about how users interact with narrowcast messages or broadcast messages sent from your LINE Official Account.
        # @see https://developers.line.biz/en/reference/messaging-api/#get-insight-message-event-response
        class GetMessageEventResponse
          # @!attribute [rw] overview
          #   @return [GetMessageEventResponseOverview] 
          attr_accessor :overview
          # @!attribute [rw] messages
          #   @return [Array[GetMessageEventResponseMessage]] Array of information about individual message bubbles.
          attr_accessor :messages
          # @!attribute [rw] clicks
          #   @return [Array[GetMessageEventResponseClick]] Array of information about opened URLs in the message.
          attr_accessor :clicks

          # @param overview [GetMessageEventResponseOverview] 
          # @param messages [Array[GetMessageEventResponseMessage]] Array of information about individual message bubbles.
          # @param clicks [Array[GetMessageEventResponseClick]] Array of information about opened URLs in the message.
          def initialize(
            overview: nil,
            messages: nil,
            clicks: nil,
            **dynamic_attributes
          )
            
            @overview = overview.is_a?(Line::Bot::V2::Insight::GetMessageEventResponseOverview) || overview.nil? ? overview : Line::Bot::V2::Insight::GetMessageEventResponseOverview.create(**overview)
            @messages = messages&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Insight::GetMessageEventResponseMessage.create(**item)
              else
                item
              end
            end
            @clicks = clicks&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Insight::GetMessageEventResponseClick.create(**item)
              else
                item
              end
            end

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
