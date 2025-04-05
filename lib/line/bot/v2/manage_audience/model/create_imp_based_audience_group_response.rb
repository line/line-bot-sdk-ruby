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
      module ManageAudience
        # Create audience for impression-based retargeting
        # @see https://developers.line.biz/en/reference/messaging-api/#create-imp-audience-group
        class CreateImpBasedAudienceGroupResponse
          # @!attribute [rw] audience_group_id
          #   @return [Integer] The audience ID.
          attr_accessor :audience_group_id
          # @!attribute [rw] type
          #   @return [String] ('UPLOAD'|'CLICK'|'IMP'|'CHAT_TAG'|'FRIEND_PATH'|'RESERVATION'|'APP_EVENT'|'VIDEO_VIEW'|'WEBTRAFFIC'|'IMAGE_CLICK'|'RICHMENU_IMP'|'RICHMENU_CLICK') 
          attr_accessor :type
          # @!attribute [rw] description
          #   @return [String] The audience's name.
          attr_accessor :description
          # @!attribute [rw] created
          #   @return [Integer] When the audience was created (in UNIX time).
          attr_accessor :created
          # @!attribute [rw] request_id
          #   @return [String] The request ID that was specified when the audience was created.
          attr_accessor :request_id

          # @param audience_group_id [Integer] The audience ID.
          # @param type [String] ('UPLOAD'|'CLICK'|'IMP'|'CHAT_TAG'|'FRIEND_PATH'|'RESERVATION'|'APP_EVENT'|'VIDEO_VIEW'|'WEBTRAFFIC'|'IMAGE_CLICK'|'RICHMENU_IMP'|'RICHMENU_CLICK') 
          # @param description [String] The audience's name.
          # @param created [Integer] When the audience was created (in UNIX time).
          # @param request_id [String] The request ID that was specified when the audience was created.
          def initialize(
            audience_group_id: nil,
            type: nil,
            description: nil,
            created: nil,
            request_id: nil,
            **dynamic_attributes
          )
            
            @audience_group_id = audience_group_id
            @type = type
            @description = description
            @created = created
            @request_id = request_id

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
