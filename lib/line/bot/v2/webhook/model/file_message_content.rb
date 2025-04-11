# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './message_content'

module Line
  module Bot
    module V2
      module Webhook
        class FileMessageContent < MessageContent
          # @!attribute [r] type
          #   @return [String] Type
          attr_reader :type
          # @!attribute [rw] id
          #   @return [String] Message ID
          attr_accessor :id
          # @!attribute [rw] file_name
          #   @return [String] File name
          attr_accessor :file_name
          # @!attribute [rw] file_size
          #   @return [Integer] File size in bytes
          attr_accessor :file_size

          # @param id [String] Message ID
          # @param file_name [String] File name
          # @param file_size [Integer] File size in bytes
          def initialize(
            id:,
            file_name:,
            file_size:,
            **dynamic_attributes
          )
            @type = "file"
            
            @id = id
            @file_name = file_name
            @file_size = file_size

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

          def self.create(args) # steep:ignore
            return new(**args) # steep:ignore
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
