# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './source'

module Line
  module Bot
    module V2
      module Webhook
        class UserSource < Source
          # @!attribute [r] type
          #   @return [String] source type
          attr_reader :type
          # @!attribute [rw] user_id
          #   @return [String,nil] ID of the source user
          attr_accessor :user_id

          # @param user_id [String,nil] ID of the source user
          def initialize(
            user_id: nil,
            **dynamic_attributes
          )
            @type = "user"
            
            @user_id = user_id

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
