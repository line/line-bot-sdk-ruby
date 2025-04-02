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
          attr_reader :type
          attr_accessor :columns
          attr_accessor :image_aspect_ratio
          attr_accessor :image_size

          def initialize(
            columns:,
            image_aspect_ratio: nil,
            image_size: nil,
            **dynamic_attributes
          )
            @type = "carousel"
            
            @columns = columns
            @image_aspect_ratio = image_aspect_ratio
            @image_size = image_size

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end
    end
  end
end
