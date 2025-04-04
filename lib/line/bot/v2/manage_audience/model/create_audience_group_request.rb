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
        # Create audience for uploading user IDs (by JSON)
        # @see https://developers.line.biz/en/reference/messaging-api/#create-upload-audience-group
        class CreateAudienceGroupRequest
          attr_accessor :description # The audience's name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120 
          attr_accessor :is_ifa_audience # To specify recipients by IFAs: set true. To specify recipients by user IDs: set false or omit isIfaAudience property. 
          attr_accessor :upload_description # The description to register for the job (in jobs[].description). 
          attr_accessor :audiences # An array of user IDs or IFAs. Max number: 10,000 

          def initialize(
            description: nil,
            is_ifa_audience: nil,
            upload_description: nil,
            audiences: nil,
            **dynamic_attributes
          )
            
            @description = description
            @is_ifa_audience = is_ifa_audience
            @upload_description = upload_description
            @audiences = audiences&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::ManageAudience::Audience.create(**item)
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

          def self.create(args)
            return new(**args)
          end
        end
      end
    end
  end
end
