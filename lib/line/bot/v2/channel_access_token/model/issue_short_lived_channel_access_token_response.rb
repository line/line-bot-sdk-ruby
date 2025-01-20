# Channel Access Token API
# This document describes Channel Access Token API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

# Issued short-lived channel access token
# @see https://developers.line.biz/en/reference/messaging-api/#issue-shortlived-channel-access-token
module Line
  module Bot
    module V2
      module ChannelAccessToken
        class IssueShortLivedChannelAccessTokenResponse
          attr_accessor :access_token # A short-lived channel access token. Valid for 30 days. Note: Channel access tokens cannot be refreshed. 
          attr_accessor :expires_in # Time until channel access token expires in seconds from time the token is issued.
          attr_accessor :token_type # Token type. The value is always `Bearer`.

          def initialize(
            access_token:,
            expires_in:,
            token_type: 'Bearer'
          )
            
            @access_token = access_token
            @expires_in = expires_in
            @token_type = token_type
          end
        end
      end
    end
  end
end
