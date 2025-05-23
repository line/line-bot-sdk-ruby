# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './action'

module Line
  module Bot
    module V2
      module MessagingApi
        class URIAction < Action
          # @!attribute [r] type
          #   @return [String,nil] Type of action
          attr_reader :type
          # @!attribute [rw] label
          #   @return [String,nil] Label for the action.
          attr_accessor :label
          # @!attribute [rw] uri
          #   @return [String,nil] 
          attr_accessor :uri
          # @!attribute [rw] alt_uri
          #   @return [AltUri,nil] 
          attr_accessor :alt_uri

          # @param label [String,nil] Label for the action.
          # @param uri [String,nil] 
          # @param alt_uri [AltUri, Hash[Symbol, untyped], nil] 
          def initialize(
            label: nil,
            uri: nil,
            alt_uri: nil,
            **dynamic_attributes
          )
            @type = "uri"
            
            @label = label
            @uri = uri
            @alt_uri = alt_uri.is_a?(Line::Bot::V2::MessagingApi::AltUri) || alt_uri.nil? ? alt_uri : Line::Bot::V2::MessagingApi::AltUri.create(**alt_uri) # steep:ignore

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
          # @return [Line::Bot::V2::MessagingApi::URIAction] Instance of the class
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
