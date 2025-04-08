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
        # @see https://developers.line.biz/en/reference/messaging-api/#create-rich-menu-alias
        class CreateRichMenuAliasRequest
          # @!attribute [rw] rich_menu_alias_id
          #   @return [String] Rich menu alias ID, which can be any ID, unique for each channel.
          attr_accessor :rich_menu_alias_id
          # @!attribute [rw] rich_menu_id
          #   @return [String] The rich menu ID to be associated with the rich menu alias.
          attr_accessor :rich_menu_id

          # @param rich_menu_alias_id [String] Rich menu alias ID, which can be any ID, unique for each channel.
          # @param rich_menu_id [String] The rich menu ID to be associated with the rich menu alias.
          def initialize(
            rich_menu_alias_id:,
            rich_menu_id:,
            **dynamic_attributes
          )
            
            @rich_menu_alias_id = rich_menu_alias_id
            @rich_menu_id = rich_menu_id

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
