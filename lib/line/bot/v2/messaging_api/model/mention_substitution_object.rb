# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './substitution_object'

module Line
  module Bot
    module V2
      module MessagingApi
        # An object representing a mention substitution.
        # @see https://developers.line.biz/en/reference/messaging-api/#text-message-v2-mention-object
        class MentionSubstitutionObject < SubstitutionObject
          attr_reader :type # Type of substitution object
          attr_accessor :mentionee

          def initialize(
            mentionee:,
            **dynamic_attributes
          )
            @type = "mention"
            
            @mentionee = mentionee.is_a?(Line::Bot::V2::MessagingApi::MentionTarget) ? mentionee : Line::Bot::V2::MessagingApi::MentionTarget.create(**mentionee)

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
