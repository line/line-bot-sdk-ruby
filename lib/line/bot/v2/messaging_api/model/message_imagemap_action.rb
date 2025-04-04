# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './imagemap_action'

module Line
  module Bot
    module V2
      module MessagingApi
        class MessageImagemapAction < ImagemapAction
          attr_reader :type
          attr_accessor :area
          attr_accessor :text
          attr_accessor :label

          def initialize(
            area:,
            text:,
            label: nil,
            **dynamic_attributes
          )
            @type = "message"
            
            @area = area.is_a?(Line::Bot::V2::MessagingApi::ImagemapArea) ? area : Line::Bot::V2::MessagingApi::ImagemapArea.create(**area)
            @text = text
            @label = label

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
