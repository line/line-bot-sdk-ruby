# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Create audience for click-based retargeting
# @see https://developers.line.biz/en/reference/messaging-api/#create-click-audience-group
module Line
  module Bot
    module V2
      module ManageAudience
        class CreateClickBasedAudienceGroupResponse
          attr_accessor :audience_group_id # The audience ID.
          attr_accessor :type
          attr_accessor :description # The audience's name.
          attr_accessor :created # When the audience was created (in UNIX time).
          attr_accessor :request_id # The request ID that was specified when the audience was created.
          attr_accessor :click_url # The URL that was specified when the audience was created.
          attr_accessor :create_route # How the audience was created. `MESSAGING_API`: An audience created with Messaging API. 
          attr_accessor :permission # Audience's update permission. Audiences linked to the same channel will be READ_WRITE.  - `READ`: Can use only. - `READ_WRITE`: Can use and update. 
          attr_accessor :expire_timestamp # Time of audience expiration. Only returned for specific audiences.
          attr_accessor :is_ifa_audience # The value indicating the type of account to be sent, as specified when creating the audience for uploading user IDs. One of:  true: Accounts are specified with IFAs. false (default): Accounts are specified with user IDs. 

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
            is_ifa_audience: false
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
          end
        end
      end
    end
  end
end