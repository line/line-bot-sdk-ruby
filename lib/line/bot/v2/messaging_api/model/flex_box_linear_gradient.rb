# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './flex_box_background'

module Line
  module Bot
    module V2
      module MessagingApi
        class FlexBoxLinearGradient < FlexBoxBackground
          # @!attribute [r] type
          #   @return [String] 
          attr_reader :type
          # @!attribute [rw] angle
          #   @return [String] 
          attr_accessor :angle
          # @!attribute [rw] start_color
          #   @return [String] 
          attr_accessor :start_color
          # @!attribute [rw] end_color
          #   @return [String] 
          attr_accessor :end_color
          # @!attribute [rw] center_color
          #   @return [String] 
          attr_accessor :center_color
          # @!attribute [rw] center_position
          #   @return [String] 
          attr_accessor :center_position

          # @param angle [String] 
          # @param start_color [String] 
          # @param end_color [String] 
          # @param center_color [String] 
          # @param center_position [String] 
          def initialize(
            angle: nil,
            start_color: nil,
            end_color: nil,
            center_color: nil,
            center_position: nil,
            **dynamic_attributes
          )
            @type = "linearGradient"
            
            @angle = angle
            @start_color = start_color
            @end_color = end_color
            @center_color = center_color
            @center_position = center_position

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
