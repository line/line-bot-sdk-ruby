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
        # @see https://developers.line.biz/en/reference/messaging-api/#link-rich-menu-to-users
        class RichMenuBulkLinkRequest
          # @!attribute [rw] rich_menu_id
          #   @return [String] ID of a rich menu
          attr_accessor :rich_menu_id
          # @!attribute [rw] user_ids
          #   @return [Array[String]] Array of user IDs. Found in the `source` object of webhook event objects. Do not use the LINE ID used in LINE.
          attr_accessor :user_ids

          # @param rich_menu_id [String] ID of a rich menu
          # @param user_ids [Array[String]] Array of user IDs. Found in the `source` object of webhook event objects. Do not use the LINE ID used in LINE.
          def initialize(
            rich_menu_id:,
            user_ids:,
            **dynamic_attributes
          )
            
            @rich_menu_id = rich_menu_id
            @user_ids = user_ids.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::string.create(**item)
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

          def self.create(args) # steep:ignore
            return new(**args) # steep:ignore
          end
        end
      end
    end
  end
end
