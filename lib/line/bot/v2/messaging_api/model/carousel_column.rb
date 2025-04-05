# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module MessagingApi
        # Column object for carousel template.
        class CarouselColumn
          # @!attribute [rw] thumbnail_image_url
          #   @return [String] 
          attr_accessor :thumbnail_image_url
          # @!attribute [rw] image_background_color
          #   @return [String] 
          attr_accessor :image_background_color
          # @!attribute [rw] title
          #   @return [String] 
          attr_accessor :title
          # @!attribute [rw] text
          #   @return [String] 
          attr_accessor :text
          # @!attribute [rw] default_action
          #   @return [Action] 
          attr_accessor :default_action
          # @!attribute [rw] actions
          #   @return [Array[Action]] 
          attr_accessor :actions

          # @param thumbnail_image_url [String] 
          # @param image_background_color [String] 
          # @param title [String] 
          # @param text [String] 
          # @param default_action [Action] 
          # @param actions [Array[Action]] 
          def initialize(
            thumbnail_image_url: nil,
            image_background_color: nil,
            title: nil,
            text:,
            default_action: nil,
            actions:,
            **dynamic_attributes
          )
            
            @thumbnail_image_url = thumbnail_image_url
            @image_background_color = image_background_color
            @title = title
            @text = text
            @default_action = default_action.is_a?(Line::Bot::V2::MessagingApi::Action) || default_action.nil? ? default_action : Line::Bot::V2::MessagingApi::Action.create(**default_action)
            @actions = actions.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::Action.create(**item)
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
