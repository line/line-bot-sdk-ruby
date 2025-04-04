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
        # List of bots to which the module is attached
        # @see https://developers.line.biz/en/reference/partner-docs/#get-multiple-bot-info-api
        class GetModulesResponse
          attr_accessor :bots # Array of Bot list Item objects representing basic information about the bot.
          attr_accessor :_next # Continuation token. Used to get the next array of basic bot information. This property is only returned if there are more unreturned results. 

          def initialize(
            bots:,
            _next: nil,
            **dynamic_attributes
          )
            
            @bots = bots.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Module::ModuleBot.create(**item)
              else
                item
              end
            end
            @_next = _next

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
