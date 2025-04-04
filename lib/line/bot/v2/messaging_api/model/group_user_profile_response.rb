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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-group-member-profile
        class GroupUserProfileResponse
          attr_accessor :display_name # User's display name
          attr_accessor :user_id # User ID
          attr_accessor :picture_url # Profile image URL. `https` image URL. Not included in the response if the user doesn't have a profile image.

          def initialize(
            display_name:,
            user_id:,
            picture_url: nil,
            **dynamic_attributes
          )
            
            @display_name = display_name
            @user_id = user_id
            @picture_url = picture_url

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
