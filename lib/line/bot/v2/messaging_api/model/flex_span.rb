# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './flex_component'

module Line
  module Bot
    module V2
      module MessagingApi
        class FlexSpan < FlexComponent
          # @!attribute [r] type
          #   @return [String] 
          attr_reader :type
          # @!attribute [rw] text
          #   @return [String] 
          attr_accessor :text
          # @!attribute [rw] size
          #   @return [String] 
          attr_accessor :size
          # @!attribute [rw] color
          #   @return [String] 
          attr_accessor :color
          # @!attribute [rw] weight
          #   @return [String] ('regular'|'bold') 
          attr_accessor :weight
          # @!attribute [rw] style
          #   @return [String] ('normal'|'italic') 
          attr_accessor :style
          # @!attribute [rw] decoration
          #   @return [String] ('none'|'underline'|'line-through') 
          attr_accessor :decoration

          # @param text [String] 
          # @param size [String] 
          # @param color [String] 
          # @param weight [String] ('regular'|'bold') 
          # @param style [String] ('normal'|'italic') 
          # @param decoration [String] ('none'|'underline'|'line-through') 
          def initialize(
            text: nil,
            size: nil,
            color: nil,
            weight: nil,
            style: nil,
            decoration: nil,
            **dynamic_attributes
          )
            @type = "span"
            
            @text = text
            @size = size
            @color = color
            @weight = weight
            @style = style
            @decoration = decoration

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
