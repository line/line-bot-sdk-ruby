# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './flex_component'

module Line
  module Bot
    module V2
      module MessagingApi
        class FlexVideo < FlexComponent
          # @!attribute [r] type
          #   @return [String] 
          attr_reader :type
          # @!attribute [rw] url
          #   @return [String] 
          attr_accessor :url
          # @!attribute [rw] preview_url
          #   @return [String] 
          attr_accessor :preview_url
          # @!attribute [rw] alt_content
          #   @return [FlexComponent] 
          attr_accessor :alt_content
          # @!attribute [rw] aspect_ratio
          #   @return [String,nil] 
          attr_accessor :aspect_ratio
          # @!attribute [rw] action
          #   @return [Action,nil] 
          attr_accessor :action

          # @param url [String] 
          # @param preview_url [String] 
          # @param alt_content [FlexComponent] 
          # @param aspect_ratio [String,nil] 
          # @param action [Action,nil] 
          def initialize(
            url:,
            preview_url:,
            alt_content:,
            aspect_ratio: nil,
            action: nil,
            **dynamic_attributes
          )
            @type = "video"
            
            @url = url
            @preview_url = preview_url
            @alt_content = alt_content.is_a?(Line::Bot::V2::MessagingApi::FlexComponent) ? alt_content : Line::Bot::V2::MessagingApi::FlexComponent.create(**alt_content)
            @aspect_ratio = aspect_ratio
            @action = action.is_a?(Line::Bot::V2::MessagingApi::Action) || action.nil? ? action : Line::Bot::V2::MessagingApi::Action.create(**action)

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
