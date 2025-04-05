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
        # Create audience for impression-based retargeting
        # @see https://developers.line.biz/en/reference/messaging-api/#create-imp-audience-group
        class CreateImpBasedAudienceGroupRequest
          # @!attribute [rw] description
          #   @return [String] The audience's name. This is case-insensitive, meaning `AUDIENCE` and `audience` are considered identical. Max character limit: 120 
          attr_accessor :description
          # @!attribute [rw] request_id
          #   @return [String] The request ID of a broadcast or narrowcast message sent in the past 60 days. Each Messaging API request has a request ID. 
          attr_accessor :request_id

          # @param description [String] The audience's name. This is case-insensitive, meaning `AUDIENCE` and `audience` are considered identical. Max character limit: 120 
          # @param request_id [String] The request ID of a broadcast or narrowcast message sent in the past 60 days. Each Messaging API request has a request ID. 
          def initialize(
            description: nil,
            request_id: nil,
            **dynamic_attributes
          )
            
            @description = description
            @request_id = request_id

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
