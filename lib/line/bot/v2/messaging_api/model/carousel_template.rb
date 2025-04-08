# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './template'

module Line
  module Bot
    module V2
      module MessagingApi
        class CarouselTemplate < Template
          # @!attribute [r] type
          #   @return [String] 
          attr_reader :type
          # @!attribute [rw] columns
          #   @return [Array[CarouselColumn]] 
          attr_accessor :columns
          # @!attribute [rw] image_aspect_ratio
          #   @return [String,nil] 
          attr_accessor :image_aspect_ratio
          # @!attribute [rw] image_size
          #   @return [String,nil] 
          attr_accessor :image_size

          # @param columns [Array[CarouselColumn]] 
          # @param image_aspect_ratio [String,nil] 
          # @param image_size [String,nil] 
          def initialize(
            columns:,
            image_aspect_ratio: nil,
            image_size: nil,
            **dynamic_attributes
          )
            @type = "carousel"
            
            @columns = columns.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::CarouselColumn.create(**item)
              else
                item
              end
            end
            @image_aspect_ratio = image_aspect_ratio
            @image_size = image_size

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
