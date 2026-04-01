          # Issues a new stateless channel access token by JWT assertion.
          # This is a convenience wrapper that only requires the parameters needed for JWT assertion authentication.
          #
          # @param client_assertion [String] A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
          # @return [Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse]
          def issue_stateless_channel_token_by_jwt_assertion(
            client_assertion:
          )
            issue_stateless_channel_token(
              grant_type: 'client_credentials',
              client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
              client_assertion: client_assertion
            )
          end

          # Issues a new stateless channel access token by client secret.
          # This is a convenience wrapper that only requires the parameters needed for client secret authentication.
          #
          # @param client_id [String] Channel ID.
          # @param client_secret [String] Channel secret.
          # @return [Line::Bot::V2::ChannelAccessToken::IssueStatelessChannelAccessTokenResponse]
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
