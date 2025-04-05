# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './rich_menu_batch_operation'

module Line
  module Bot
    module V2
      module MessagingApi
        # Unlink the rich menu for all users linked to the rich menu specified in the `from` property.
        class RichMenuBatchUnlinkOperation < RichMenuBatchOperation
          attr_reader :type # The type of operation to the rich menu linked to the user. One of link, unlink, or unlinkAll.
          attr_accessor :from

          # @param from [String] 
          def initialize(
            from:,
            **dynamic_attributes
          )
            @type = "unlink"
            
            @from = from

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
