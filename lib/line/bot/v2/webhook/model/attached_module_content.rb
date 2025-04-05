# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './module_content'

module Line
  module Bot
    module V2
      module Webhook
        class AttachedModuleContent < ModuleContent
          # @!attribute [r] type
          #   @return [String] Type
          attr_reader :type
          # @!attribute [rw] bot_id
          #   @return [String] User ID of the bot on the attached LINE Official Account
          attr_accessor :bot_id
          # @!attribute [rw] scopes
          #   @return [Array[String]] An array of strings indicating the scope permitted by the admin of the LINE Official Account.
          attr_accessor :scopes

          # @param bot_id [String] User ID of the bot on the attached LINE Official Account
          # @param scopes [Array[String]] An array of strings indicating the scope permitted by the admin of the LINE Official Account.
          def initialize(
            bot_id:,
            scopes:,
            **dynamic_attributes
          )
            @type = "attached"
            
            @bot_id = bot_id
            @scopes = scopes.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Webhook::string.create(**item)
              else
                item
              end
            end

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
