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
        class AddLiffAppRequest
          # @!attribute [rw] view
          #   @return [LiffView] 
          attr_accessor :view
          # @!attribute [rw] description
          #   @return [String,nil] Name of the LIFF app.  The LIFF app name can't include \"LINE\" or similar strings, or inappropriate strings. 
          attr_accessor :description
          # @!attribute [rw] features
          #   @return [LiffFeatures,nil] 
          attr_accessor :features
          # @!attribute [rw] permanent_link_pattern
          #   @return [String,nil] How additional information in LIFF URLs is handled. Specify `concat`. 
          attr_accessor :permanent_link_pattern
          # @!attribute [rw] scope
          #   @return [Array['openid'|'email'|'profile'|'chat_message.write']] 
          attr_accessor :scope
          # @!attribute [rw] bot_prompt
          #   @return [String,nil] ('normal'|'aggressive'|'none') 
          attr_accessor :bot_prompt

          # @param view [LiffView] 
          # @param description [String,nil] Name of the LIFF app.  The LIFF app name can't include \"LINE\" or similar strings, or inappropriate strings. 
          # @param features [LiffFeatures,nil] 
          # @param permanent_link_pattern [String,nil] How additional information in LIFF URLs is handled. Specify `concat`. 
          # @param scope [Array['openid'|'email'|'profile'|'chat_message.write'],nil] 
          # @param bot_prompt [String,nil] ('normal'|'aggressive'|'none') 
          def initialize(
            view:,
            description: nil,
            features: nil,
            permanent_link_pattern: nil,
            scope: nil,
            bot_prompt: nil,
            **dynamic_attributes
          )
            
            @view = view.is_a?(Line::Bot::V2::Liff::LiffView) ? view : Line::Bot::V2::Liff::LiffView.create(**view) # steep:ignore
            @description = description
            @features = features.is_a?(Line::Bot::V2::Liff::LiffFeatures) || features.nil? ? features : Line::Bot::V2::Liff::LiffFeatures.create(**features) # steep:ignore
            @permanent_link_pattern = permanent_link_pattern
            @scope = scope
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

          def self.create(args) # steep:ignore
            return new(**args) # steep:ignore
          end

          # @param other [Object] Object to compare
          # @return [Boolean] true if the objects are equal, false otherwise
          def ==(other)
            return false unless self.class == other.class

            instance_variables.all? do |var|
                instance_variable_get(var) == other.instance_variable_get(var)
            end
          end

          # @return [Integer] Hash code of the object
          def hash
            [self.class, *instance_variables.map { |var| instance_variable_get(var) }].hash
          end
        end
      end
    end
  end
end
