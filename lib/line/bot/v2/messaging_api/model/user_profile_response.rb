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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-profile
        class UserProfileResponse
          # @!attribute [rw] display_name
          #   @return [String] User's display name
          attr_accessor :display_name
          # @!attribute [rw] user_id
          #   @return [String] User ID
          attr_accessor :user_id
          # @!attribute [rw] picture_url
          #   @return [String,nil] Profile image URL. `https` image URL. Not included in the response if the user doesn't have a profile image.
          attr_accessor :picture_url
          # @!attribute [rw] status_message
          #   @return [String,nil] User's status message. Not included in the response if the user doesn't have a status message.
          attr_accessor :status_message
          # @!attribute [rw] language
          #   @return [String,nil] User's language, as a BCP 47 language tag. Not included in the response if the user hasn't yet consented to the LINE Privacy Policy.
          attr_accessor :language

          # @param display_name [String] User's display name
          # @param user_id [String] User ID
          # @param picture_url [String,nil] Profile image URL. `https` image URL. Not included in the response if the user doesn't have a profile image.
          # @param status_message [String,nil] User's status message. Not included in the response if the user doesn't have a status message.
          # @param language [String,nil] User's language, as a BCP 47 language tag. Not included in the response if the user hasn't yet consented to the LINE Privacy Policy.
          def initialize(
            display_name:,
            user_id:,
            picture_url: nil,
            status_message: nil,
            language: nil,
            **dynamic_attributes
          )
            
            @display_name = display_name
            @user_id = user_id
            @picture_url = picture_url
            @status_message = status_message
            @language = language

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
