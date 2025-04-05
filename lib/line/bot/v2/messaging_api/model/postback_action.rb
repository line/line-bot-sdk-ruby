# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './action'

module Line
  module Bot
    module V2
      module MessagingApi
        class PostbackAction < Action
          # @!attribute [r] type
          #   @return [String,nil] Type of action
          attr_reader :type
          # @!attribute [rw] label
          #   @return [String,nil] Label for the action.
          attr_accessor :label
          # @!attribute [rw] data
          #   @return [String,nil] 
          attr_accessor :data
          # @!attribute [rw] display_text
          #   @return [String,nil] 
          attr_accessor :display_text
          # @!attribute [rw] text
          #   @return [String,nil] 
          attr_accessor :text
          # @!attribute [rw] input_option
          #   @return [String,nil] ('closeRichMenu'|'openRichMenu'|'openKeyboard'|'openVoice') 
          attr_accessor :input_option
          # @!attribute [rw] fill_in_text
          #   @return [String,nil] 
          attr_accessor :fill_in_text

          # @param label [String,nil] Label for the action.
          # @param data [String,nil] 
          # @param display_text [String,nil] 
          # @param text [String,nil] 
          # @param input_option [String,nil] ('closeRichMenu'|'openRichMenu'|'openKeyboard'|'openVoice') 
          # @param fill_in_text [String,nil] 
          def initialize(
            label: nil,
            data: nil,
            display_text: nil,
            text: nil,
            input_option: nil,
            fill_in_text: nil,
            **dynamic_attributes
          )
            @type = "postback"
            
            @label = label
            @data = data
            @display_text = display_text
            @text = text
            @input_option = input_option
            @fill_in_text = fill_in_text

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
