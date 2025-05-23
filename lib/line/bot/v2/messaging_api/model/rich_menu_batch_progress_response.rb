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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-batch-control-rich-menus-progress-status-response
        class RichMenuBatchProgressResponse
          # @!attribute [rw] phase
          #   @return [String] ('ongoing'|'succeeded'|'failed') 
          attr_accessor :phase
          # @!attribute [rw] accepted_time
          #   @return [String] The accepted time in milliseconds of the request of batch control the rich menu.  Format: ISO 8601 (e.g. 2023-06-08T10:15:30.121Z) Timezone: UTC 
          attr_accessor :accepted_time
          # @!attribute [rw] completed_time
          #   @return [String,nil] The completed time in milliseconds of rich menu batch control. Returned when the phase property is succeeded or failed.  Format: ISO 8601 (e.g. 2023-06-08T10:15:30.121Z) Timezone: UTC 
          attr_accessor :completed_time

          # @param phase [String] ('ongoing'|'succeeded'|'failed') 
          # @param accepted_time [String] The accepted time in milliseconds of the request of batch control the rich menu.  Format: ISO 8601 (e.g. 2023-06-08T10:15:30.121Z) Timezone: UTC 
          # @param completed_time [String,nil] The completed time in milliseconds of rich menu batch control. Returned when the phase property is succeeded or failed.  Format: ISO 8601 (e.g. 2023-06-08T10:15:30.121Z) Timezone: UTC 
          def initialize(
            phase:,
            accepted_time:,
            completed_time: nil,
            **dynamic_attributes
          )
            
            @phase = phase
            @accepted_time = accepted_time
            @completed_time = completed_time

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
          # @return [Line::Bot::V2::MessagingApi::RichMenuBatchProgressResponse] Instance of the class
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
