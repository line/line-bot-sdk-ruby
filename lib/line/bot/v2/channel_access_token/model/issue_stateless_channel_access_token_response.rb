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
        # Issued stateless channel access token
        # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
        class IssueStatelessChannelAccessTokenResponse
          # @!attribute [rw] access_token
          #   @return [String] A stateless channel access token. The token is an opaque string which means its format is an implementation detail and the consumer of this token should never try to use the data parsed from the token. 
          attr_accessor :access_token
          # @!attribute [rw] expires_in
          #   @return [Integer] Duration in seconds after which the issued access token expires
          attr_accessor :expires_in
          # @!attribute [rw] token_type
          #   @return [String] Token type. The value is always `Bearer`.
          attr_accessor :token_type

          # @param access_token [String] A stateless channel access token. The token is an opaque string which means its format is an implementation detail and the consumer of this token should never try to use the data parsed from the token. 
          # @param expires_in [Integer] Duration in seconds after which the issued access token expires
          # @param token_type [String] Token type. The value is always `Bearer`.
          def initialize(
            access_token:,
            expires_in:,
            token_type: 'Bearer',
            **dynamic_attributes
          )
            
            @access_token = access_token
            @expires_in = expires_in
            @token_type = token_type

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
        end
      end
    end
  end
end
