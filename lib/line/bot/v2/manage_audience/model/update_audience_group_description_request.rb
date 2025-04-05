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
      module ManageAudience
        # Rename an audience
        # @see https://developers.line.biz/en/reference/messaging-api/#set-description-audience-group
        class UpdateAudienceGroupDescriptionRequest
          attr_accessor :description # The audience's name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120 

          # @param description [String] The audience's name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120 
          def initialize(
            description: nil,
            **dynamic_attributes
          )
            
            @description = description

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
