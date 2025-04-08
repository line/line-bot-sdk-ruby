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
        # Action
        # @see https://developers.line.biz/en/reference/messaging-api/#action-objects
        class Action
          # @!attribute [rw] type
          #   @return [String,nil] Type of action
          attr_accessor :type
          # @!attribute [rw] label
          #   @return [String,nil] Label for the action.
          attr_accessor :label

          # @param type [String,nil] Type of action
          # @param label [String,nil] Label for the action.
          def initialize(
            type: nil,
            label: nil,
            **dynamic_attributes
          )
            
            @type = type
            @label = label

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
              camera: Line::Bot::V2::MessagingApi::CameraAction,
              cameraRoll: Line::Bot::V2::MessagingApi::CameraRollAction,
              clipboard: Line::Bot::V2::MessagingApi::ClipboardAction,
              datetimepicker: Line::Bot::V2::MessagingApi::DatetimePickerAction,
              location: Line::Bot::V2::MessagingApi::LocationAction,
              message: Line::Bot::V2::MessagingApi::MessageAction,
              postback: Line::Bot::V2::MessagingApi::PostbackAction,
              richmenuswitch: Line::Bot::V2::MessagingApi::RichMenuSwitchAction,
              uri: Line::Bot::V2::MessagingApi::URIAction,
            }[type.to_sym]
          end
        end
      end
    end
  end
end
