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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-group-summary
        class GroupSummaryResponse
          # @!attribute [rw] group_id
          #   @return [String] Group ID
          attr_accessor :group_id
          # @!attribute [rw] group_name
          #   @return [String] Group name
          attr_accessor :group_name
          # @!attribute [rw] picture_url
          #   @return [String,nil] Group icon URL. Not included in the response if the user doesn't set a group profile icon.
          attr_accessor :picture_url

          # @param group_id [String] Group ID
          # @param group_name [String] Group name
          # @param picture_url [String,nil] Group icon URL. Not included in the response if the user doesn't set a group profile icon.
          def initialize(
            group_id:,
            group_name:,
            picture_url: nil,
            **dynamic_attributes
          )
            
            @group_id = group_id
            @group_name = group_name
            @picture_url = picture_url

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

          # Create an instance of the class from a hash
          # @param args [Hash] Hash containing all the required attributes
          # @return [Line::Bot::V2::MessagingApi::GroupSummaryResponse] Instance of the class
          def self.create(args) # steep:ignore
            symbolized_args = Line::Bot::V2::Utils.deep_symbolize(args)
            return new(**symbolized_args) # steep:ignore
          end

          # @param other [Object] Object to compare
          # @return [Boolean] true if the objects are equal, false otherwise
          def ==(other)
            return false unless self.class == other.class

            instance_variables.all? do |var|
                instance_variable_get(var) == other.instance_variable_get(var)
            end
          end

          # @return [Integer] Hash code of the object
          def hash
            [self.class, *instance_variables.map { |var| instance_variable_get(var) }].hash
          end
        end
      end
    end
  end
end
