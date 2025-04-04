# LIFF server API
# LIFF Server API.
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Liff
        # @see https://developers.line.biz/en/reference/liff-server/#add-liff-app
        class UpdateLiffAppRequest
          attr_accessor :view
          attr_accessor :description # Name of the LIFF app.  The LIFF app name can't include \"LINE\" or similar strings, or inappropriate strings. 
          attr_accessor :features
          attr_accessor :permanent_link_pattern # How additional information in LIFF URLs is handled. Specify `concat`. 
          attr_accessor :scope
          attr_accessor :bot_prompt

          def initialize(
            view: nil,
            description: nil,
            features: nil,
            permanent_link_pattern: nil,
            scope: nil,
            bot_prompt: nil,
            **dynamic_attributes
          )
            
            @view = view.is_a?(Line::Bot::V2::Liff::UpdateLiffView) || view.nil? ? view : Line::Bot::V2::Liff::UpdateLiffView.create(**view)
            @description = description
            @features = features.is_a?(Line::Bot::V2::Liff::LiffFeatures) || features.nil? ? features : Line::Bot::V2::Liff::LiffFeatures.create(**features)
            @permanent_link_pattern = permanent_link_pattern
            @scope = scope&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::Liff::LiffScope.create(**item)
              else
                item
              end
            end
            @bot_prompt = bot_prompt

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
