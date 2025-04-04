# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './flex_container'

module Line
  module Bot
    module V2
      module MessagingApi
        class FlexBubble < FlexContainer
          attr_reader :type
          attr_accessor :direction
          attr_accessor :styles
          attr_accessor :header
          attr_accessor :hero
          attr_accessor :body
          attr_accessor :footer
          attr_accessor :size
          attr_accessor :action

          def initialize(
            direction: nil,
            styles: nil,
            header: nil,
            hero: nil,
            body: nil,
            footer: nil,
            size: nil,
            action: nil,
            **dynamic_attributes
          )
            @type = "bubble"
            
            @direction = direction
            @styles = styles.is_a?(Line::Bot::V2::MessagingApi::FlexBubbleStyles) || styles.nil? ? styles : Line::Bot::V2::MessagingApi::FlexBubbleStyles.create(**styles)
            @header = header.is_a?(Line::Bot::V2::MessagingApi::FlexBox) || header.nil? ? header : Line::Bot::V2::MessagingApi::FlexBox.create(**header)
            @hero = hero.is_a?(Line::Bot::V2::MessagingApi::FlexComponent) || hero.nil? ? hero : Line::Bot::V2::MessagingApi::FlexComponent.create(**hero)
            @body = body.is_a?(Line::Bot::V2::MessagingApi::FlexBox) || body.nil? ? body : Line::Bot::V2::MessagingApi::FlexBox.create(**body)
            @footer = footer.is_a?(Line::Bot::V2::MessagingApi::FlexBox) || footer.nil? ? footer : Line::Bot::V2::MessagingApi::FlexBox.create(**footer)
            @size = size
            @action = action.is_a?(Line::Bot::V2::MessagingApi::Action) || action.nil? ? action : Line::Bot::V2::MessagingApi::Action.create(**action)

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
