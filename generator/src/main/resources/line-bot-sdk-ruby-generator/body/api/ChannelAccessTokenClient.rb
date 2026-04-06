          # Issues a new stateless channel access token by JWT assertion, which doesn't have max active token limit unlike the other token types. The newly issued token is only valid for 15 minutes but can not be revoked until it naturally expires.
          # This is a convenience wrapper that only requires the parameters needed for JWT assertion authentication.
          # This requests to <code>POST https://api.line.me/oauth2/v3/token</code>
          # When you want to get HTTP status code or response headers, use {{ '{#' }}issue_stateless_channel_token_by_jwt_assertion_with_http_info} instead of this.
          #
          # @param client_assertion [String] A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
          # @return [Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse] when HTTP status code is 200
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def issue_stateless_channel_token_by_jwt_assertion(
            client_assertion:
          )
            issue_stateless_channel_token(
              grant_type: 'client_credentials',
              client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
              client_assertion: client_assertion
            )
          end

          # Issues a new stateless channel access token by client secret, which doesn't have max active token limit unlike the other token types. The newly issued token is only valid for 15 minutes but can not be revoked until it naturally expires.
          # This is a convenience wrapper that only requires the parameters needed for client secret authentication.
          # This requests to <code>POST https://api.line.me/oauth2/v3/token</code>
          # When you want to get HTTP status code or response headers, use {{ '{#' }}issue_stateless_channel_token_by_client_secret_with_http_info} instead of this.
          #
          # @param client_id [String] Channel ID.
          # @param client_secret [String] Channel secret.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
          # @return [Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse] when HTTP status code is 200
          # @return [String, nil] when other HTTP status code is returned. This String is HTTP response body itself.
          def issue_stateless_channel_token_by_client_secret(
            client_id:,
            client_secret:
          )
            issue_stateless_channel_token(
              grant_type: 'client_credentials',
              client_id: client_id,
              client_secret: client_secret
            )
          end

          # Issues a new stateless channel access token by JWT assertion, which doesn't have max active token limit unlike the other token types. The newly issued token is only valid for 15 minutes but can not be revoked until it naturally expires.
          # This is a convenience wrapper that only requires the parameters needed for JWT assertion authentication.
          # This requests to <code>POST https://api.line.me/oauth2/v3/token</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param client_assertion [String] A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
          # @return [Array(Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse, Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def issue_stateless_channel_token_by_jwt_assertion_with_http_info(
            client_assertion:
          )
            issue_stateless_channel_token_with_http_info(
              grant_type: 'client_credentials',
              client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
              client_assertion: client_assertion
            )
          end

          # Issues a new stateless channel access token by client secret, which doesn't have max active token limit unlike the other token types. The newly issued token is only valid for 15 minutes but can not be revoked until it naturally expires.
          # This is a convenience wrapper that only requires the parameters needed for client secret authentication.
          # This requests to <code>POST https://api.line.me/oauth2/v3/token</code>
          # This returns an array containing response, HTTP status code, and header in order. Please specify all header keys in lowercase.
          #
          # @param client_id [String] Channel ID.
          # @param client_secret [String] Channel secret.
          # @see https://developers.line.biz/en/reference/messaging-api/#issue-stateless-channel-access-token
          # @return [Array(Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse, Integer, Hash{String => String})] when HTTP status code is 200
          # @return [Array((String|nil), Integer, Hash{String => String})] when other HTTP status code is returned. String is HTTP response body itself.
          def issue_stateless_channel_token_by_client_secret_with_http_info(
            client_id:,
            client_secret:
          )
            issue_stateless_channel_token_with_http_info(
              grant_type: 'client_credentials',
              client_id: client_id,
              client_secret: client_secret
            )
          end
