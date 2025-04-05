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
        class SentMessage
          # @!attribute [rw] id
          #   @return [String] ID of the sent message.
          attr_accessor :id
          # @!attribute [rw] quote_token
          #   @return [String,nil] Quote token of the message. Only included when a message object that can be specified as a quote target was sent as a push or reply message. 
          attr_accessor :quote_token

          # @param id [String] ID of the sent message.
          # @param quote_token [String,nil] Quote token of the message. Only included when a message object that can be specified as a quote target was sent as a push or reply message. 
          def initialize(
            id:,
            quote_token: nil,
            **dynamic_attributes
          )
            
            @id = id
            @quote_token = quote_token

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
