# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Webhook
        class BeaconContent
          # @!attribute [rw] hwid
          #   @return [String] Hardware ID of the beacon that was detected
          attr_accessor :hwid
          # @!attribute [rw] type
          #   @return [String] ('enter'|'banner'|'stay') Type of beacon event.
          attr_accessor :type
          # @!attribute [rw] dm
          #   @return [String,nil] Device message of beacon that was detected.
          attr_accessor :dm

          # @param hwid [String] Hardware ID of the beacon that was detected
          # @param type [String] ('enter'|'banner'|'stay') Type of beacon event.
          # @param dm [String,nil] Device message of beacon that was detected.
          def initialize(
            hwid:,
            type:,
            dm: nil,
            **dynamic_attributes
          )
            
            @hwid = hwid
            @type = type
            @dm = dm

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
          # @return [Line::Bot::V2::Webhook::BeaconContent] Instance of the class
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
