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
        # Create audience for click-based retargeting
        # @see https://developers.line.biz/en/reference/messaging-api/#create-click-audience-group
        class CreateClickBasedAudienceGroupResponse
          # @!attribute [rw] audience_group_id
          #   @return [Integer,nil] The audience ID.
          attr_accessor :audience_group_id
          # @!attribute [rw] type
          #   @return [String,nil] ('UPLOAD'|'CLICK'|'IMP'|'CHAT_TAG'|'FRIEND_PATH'|'RESERVATION'|'APP_EVENT'|'VIDEO_VIEW'|'WEBTRAFFIC'|'IMAGE_CLICK'|'RICHMENU_IMP'|'RICHMENU_CLICK') 
          attr_accessor :type
          # @!attribute [rw] description
          #   @return [String,nil] The audience's name.
          attr_accessor :description
          # @!attribute [rw] created
          #   @return [Integer,nil] When the audience was created (in UNIX time).
          attr_accessor :created
          # @!attribute [rw] request_id
          #   @return [String,nil] The request ID that was specified when the audience was created.
          attr_accessor :request_id
          # @!attribute [rw] click_url
          #   @return [String,nil] The URL that was specified when the audience was created.
          attr_accessor :click_url
          # @!attribute [rw] create_route
          #   @return [String,nil] ('MESSAGING_API') How the audience was created. `MESSAGING_API`: An audience created with Messaging API. 
          attr_accessor :create_route
          # @!attribute [rw] permission
          #   @return [String,nil] ('READ'|'READ_WRITE') Audience's update permission. Audiences linked to the same channel will be READ_WRITE.  - `READ`: Can use only. - `READ_WRITE`: Can use and update. 
          attr_accessor :permission
          # @!attribute [rw] expire_timestamp
          #   @return [Integer,nil] Time of audience expiration. Only returned for specific audiences.
          attr_accessor :expire_timestamp
          # @!attribute [rw] is_ifa_audience
          #   @return [Boolean,nil] The value indicating the type of account to be sent, as specified when creating the audience for uploading user IDs. One of:  true: Accounts are specified with IFAs. false (default): Accounts are specified with user IDs. 
          attr_accessor :is_ifa_audience

          # @param audience_group_id [Integer,nil] The audience ID.
          # @param type [String,nil] ('UPLOAD'|'CLICK'|'IMP'|'CHAT_TAG'|'FRIEND_PATH'|'RESERVATION'|'APP_EVENT'|'VIDEO_VIEW'|'WEBTRAFFIC'|'IMAGE_CLICK'|'RICHMENU_IMP'|'RICHMENU_CLICK') 
          # @param description [String,nil] The audience's name.
          # @param created [Integer,nil] When the audience was created (in UNIX time).
          # @param request_id [String,nil] The request ID that was specified when the audience was created.
          # @param click_url [String,nil] The URL that was specified when the audience was created.
          # @param create_route [String,nil] ('MESSAGING_API') How the audience was created. `MESSAGING_API`: An audience created with Messaging API. 
          # @param permission [String,nil] ('READ'|'READ_WRITE') Audience's update permission. Audiences linked to the same channel will be READ_WRITE.  - `READ`: Can use only. - `READ_WRITE`: Can use and update. 
          # @param expire_timestamp [Integer,nil] Time of audience expiration. Only returned for specific audiences.
          # @param is_ifa_audience [Boolean,nil] The value indicating the type of account to be sent, as specified when creating the audience for uploading user IDs. One of:  true: Accounts are specified with IFAs. false (default): Accounts are specified with user IDs. 
          def initialize(
            audience_group_id: nil,
            type: nil,
            description: nil,
            created: nil,
            request_id: nil,
            click_url: nil,
            create_route: nil,
            permission: nil,
            expire_timestamp: nil,
            is_ifa_audience: false,
            **dynamic_attributes
          )
            
            @audience_group_id = audience_group_id
            @type = type
            @description = description
            @created = created
            @request_id = request_id
            @click_url = click_url
            @create_route = create_route
            @permission = permission
            @expire_timestamp = expire_timestamp
            @is_ifa_audience = is_ifa_audience

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
