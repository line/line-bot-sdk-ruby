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
        # Rich menu operation object represents the batch operation to the rich menu linked to the user.
        # @see https://developers.line.biz/en/reference/messaging-api/#batch-control-rich-menus-of-users-operations
        class RichMenuBatchOperation
          attr_accessor :type # The type of operation to the rich menu linked to the user. One of link, unlink, or unlinkAll.

          def initialize(
            type:,
            **dynamic_attributes
          )
            
            @type = type

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
            klass = detect_class(args[:type])
            return klass.new(**args) if klass
            
            return new(**args)
          end

          private

          def self.detect_class(type)
            {
              link: Line::Bot::V2::MessagingApi::RichMenuBatchLinkOperation,
              unlinkAll: Line::Bot::V2::MessagingApi::RichMenuBatchUnlinkAllOperation,
              unlink: Line::Bot::V2::MessagingApi::RichMenuBatchUnlinkOperation,
            }[type.to_sym]
          end
        end
      end
    end
  end
end
