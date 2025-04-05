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
        # Demographic filter
        class DemographicFilter
          # @!attribute [rw] type
          #   @return [String] Type of demographic filter
          attr_accessor :type

          # @param type [String] Type of demographic filter
          def initialize(
            type: nil,
            **dynamic_attributes
          )
            
            @type = type

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
            klass = detect_class(args[:type])
            return klass.new(**args) if klass
            
            return new(**args)
          end

          private

          def self.detect_class(type)
            {
              age: Line::Bot::V2::MessagingApi::AgeDemographicFilter,
              appType: Line::Bot::V2::MessagingApi::AppTypeDemographicFilter,
              area: Line::Bot::V2::MessagingApi::AreaDemographicFilter,
              gender: Line::Bot::V2::MessagingApi::GenderDemographicFilter,
              operator: Line::Bot::V2::MessagingApi::OperatorDemographicFilter,
              subscriptionPeriod: Line::Bot::V2::MessagingApi::SubscriptionPeriodDemographicFilter,
            }[type.to_sym]
          end
        end
      end
    end
  end
end
