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
        class RichMenuResponse
          # @!attribute [rw] rich_menu_id
          #   @return [String] ID of a rich menu
          attr_accessor :rich_menu_id
          # @!attribute [rw] size
          #   @return [RichMenuSize] 
          attr_accessor :size
          # @!attribute [rw] selected
          #   @return [Boolean] `true` to display the rich menu by default. Otherwise, `false`.
          attr_accessor :selected
          # @!attribute [rw] name
          #   @return [String] Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users.
          attr_accessor :name
          # @!attribute [rw] chat_bar_text
          #   @return [String] Text displayed in the chat bar
          attr_accessor :chat_bar_text
          # @!attribute [rw] areas
          #   @return [Array[RichMenuArea]] Array of area objects which define the coordinates and size of tappable areas
          attr_accessor :areas

          # @param rich_menu_id [String] ID of a rich menu
          # @param size [RichMenuSize] 
          # @param selected [Boolean] `true` to display the rich menu by default. Otherwise, `false`.
          # @param name [String] Name of the rich menu. This value can be used to help manage your rich menus and is not displayed to users.
          # @param chat_bar_text [String] Text displayed in the chat bar
          # @param areas [Array[RichMenuArea]] Array of area objects which define the coordinates and size of tappable areas
          def initialize(
            rich_menu_id:,
            size:,
            selected:,
            name:,
            chat_bar_text:,
            areas:,
            **dynamic_attributes
          )
            
            @rich_menu_id = rich_menu_id
            @size = size.is_a?(Line::Bot::V2::MessagingApi::RichMenuSize) ? size : Line::Bot::V2::MessagingApi::RichMenuSize.create(**size)
            @selected = selected
            @name = name
            @chat_bar_text = chat_bar_text
            @areas = areas.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::RichMenuArea.create(**item)
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
