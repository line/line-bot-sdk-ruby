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
        class AgeDemographicFilter < DemographicFilter
          attr_reader :type # Type of demographic filter
          attr_accessor :gte
          attr_accessor :lt

          # @param gte [String] ('age_15'|'age_20'|'age_25'|'age_30'|'age_35'|'age_40'|'age_45'|'age_50'|'age_55'|'age_60'|'age_65'|'age_70') 
          # @param lt [String] ('age_15'|'age_20'|'age_25'|'age_30'|'age_35'|'age_40'|'age_45'|'age_50'|'age_55'|'age_60'|'age_65'|'age_70') 
          def initialize(
            gte: nil,
            lt: nil,
            **dynamic_attributes
          )
            @type = "age"
            
            @gte = gte
            @lt = lt

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
