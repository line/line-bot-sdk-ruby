# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './demographic_filter'

module Line
  module Bot
    module V2
      module MessagingApi
        class OperatorDemographicFilter < DemographicFilter
          # @!attribute [r] type
          #   @return [String,nil] Type of demographic filter
          attr_reader :type
          # @!attribute [rw] _and
          #   @return [Array[DemographicFilter],nil] 
          attr_accessor :_and
          # @!attribute [rw] _or
          #   @return [Array[DemographicFilter],nil] 
          attr_accessor :_or
          # @!attribute [rw] _not
          #   @return [DemographicFilter,nil] 
          attr_accessor :_not

          # @param _and [Array[DemographicFilter],nil] 
          # @param _or [Array[DemographicFilter],nil] 
          # @param _not [DemographicFilter,nil] 
          def initialize(
            _and: nil,
            _or: nil,
            _not: nil,
            **dynamic_attributes
          )
            @type = "operator"
            
            @_and = _and&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::DemographicFilter.create(**item)
              else
                item
              end
            end
            @_or = _or&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::DemographicFilter.create(**item)
              else
                item
              end
            end
            @_not = _not.is_a?(Line::Bot::V2::MessagingApi::DemographicFilter) || _not.nil? ? _not : Line::Bot::V2::MessagingApi::DemographicFilter.create(**_not) # steep:ignore

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
        end
      end
    end
  end
end
