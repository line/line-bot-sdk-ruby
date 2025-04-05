# Channel Access Token API
# This document describes Channel Access Token API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module ChannelAccessToken
        # Issued channel access token
        # @see https://developers.line.biz/en/reference/messaging-api/#issue-channel-access-token-v2-1
        class IssueChannelAccessTokenResponse
          # @!attribute [rw] access_token
          #   @return [String] Channel access token. 
          attr_accessor :access_token
          # @!attribute [rw] expires_in
          #   @return [Integer] Amount of time in seconds from issue to expiration of the channel access token
          attr_accessor :expires_in
          # @!attribute [rw] token_type
          #   @return [String] A token type.
          attr_accessor :token_type
          # @!attribute [rw] key_id
          #   @return [String] Unique key ID for identifying the channel access token.
          attr_accessor :key_id

          # @param access_token [String] Channel access token. 
          # @param expires_in [Integer] Amount of time in seconds from issue to expiration of the channel access token
          # @param token_type [String] A token type.
          # @param key_id [String] Unique key ID for identifying the channel access token.
          def initialize(
            access_token:,
            expires_in:,
            token_type: 'Bearer',
            key_id:,
            **dynamic_attributes
          )
            
            @access_token = access_token
            @expires_in = expires_in
            @token_type = token_type
            @key_id = key_id

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
