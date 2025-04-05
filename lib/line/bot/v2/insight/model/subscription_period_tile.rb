# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Insight
        class SubscriptionPeriodTile
          attr_accessor :subscription_period # Subscription period. Possible values: `within7days`, `within90days`, `unknown` etc.
          attr_accessor :percentage # Percentage. Possible values: [0.0,100.0] e.g. 0, 2.9, 37.6.

          # @param subscription_period [String] ('within7days'|'within30days'|'within90days'|'within180days'|'within365days'|'over365days'|'unknown') Subscription period. Possible values: `within7days`, `within90days`, `unknown` etc.
          # @param percentage [Float] Percentage. Possible values: [0.0,100.0] e.g. 0, 2.9, 37.6.
          def initialize(
            subscription_period: nil,
            percentage: nil,
            **dynamic_attributes
          )
            
            @subscription_period = subscription_period
            @percentage = percentage

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
