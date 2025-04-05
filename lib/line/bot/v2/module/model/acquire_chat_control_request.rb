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
      module Module
        # Request entity of the Acquire Control API
        # @see https://developers.line.biz/en/reference/partner-docs/#acquire-control-api
        class AcquireChatControlRequest
          # @!attribute [rw] expired
          #   @return [Boolean] `True`: After the time limit (ttl) has passed, the initiative (Chat Control) will return to the Primary Channel. (Default) `False`: There's no time limit and the initiative (Chat Control) doesn't change over time. 
          attr_accessor :expired
          # @!attribute [rw] ttl
          #   @return [Integer] The time it takes for initiative (Chat Control) to return to the Primary Channel (the time that the module channel stays on the Active Channel). The value is specified in seconds. The maximum value is one year (3600 * 24 * 365). The default value is 3600 (1 hour).  * Ignored if the value of expired is false. 
          attr_accessor :ttl

          # @param expired [Boolean] `True`: After the time limit (ttl) has passed, the initiative (Chat Control) will return to the Primary Channel. (Default) `False`: There's no time limit and the initiative (Chat Control) doesn't change over time. 
          # @param ttl [Integer] The time it takes for initiative (Chat Control) to return to the Primary Channel (the time that the module channel stays on the Active Channel). The value is specified in seconds. The maximum value is one year (3600 * 24 * 365). The default value is 3600 (1 hour).  * Ignored if the value of expired is false. 
          def initialize(
            expired: nil,
            ttl: nil,
            **dynamic_attributes
          )
            
            @expired = expired
            @ttl = ttl

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
