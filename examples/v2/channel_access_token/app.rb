require 'line-bot-api'

def client
  # NOTE: Don't need to set `channel_access_token` and `channel_secret` in the client.
  @client ||= Line::Bot::V2::ChannelAccessToken::ApiClient.new
end

def main
  access_token = issue_channel_access_token

  if access_token
    sleep 1
    verify_channel_access_token(access_token)
    revoke_channel_access_token(access_token)
    verify_channel_access_token(access_token)
  end
end

def issue_channel_access_token
  response = client.issue_channel_token(
    grant_type: 'client_credentials', # fixed value
    client_id: ENV.fetch('LINE_CHANNEL_ID'),
    client_secret: ENV.fetch('LINE_CHANNEL_SECRET')
  )

  if response.is_a?(Line::Bot::V2::ChannelAccessToken::IssueShortLivedChannelAccessTokenResponse)
    puts "=== access_token has been issued successfully ==="
    puts "access_token: #{response.access_token}"
    puts "expires_in: #{response.expires_in}"
    puts "token_type: #{response.token_type}"

    response.access_token
  else
    puts "=== access_token has not been issued ==="
    nil
  end
end

def verify_channel_access_token(accesss_token)
  response = client.verify_channel_token(access_token: accesss_token)

  if response.is_a?(Line::Bot::V2::ChannelAccessToken::VerifyChannelAccessTokenResponse)
    puts "=== access_token has been verified successfully ==="
    puts "client_id: #{response.client_id}"
    puts "expires_in: #{response.expires_in}"
    puts "scope: #{response.scope}"
  else
    puts "=== access_token has not been verified ==="
  end
end

def revoke_channel_access_token(accesss_token)
  _body, status_code, _http_headers = client.revoke_channel_token_with_http_info(access_token: accesss_token)
  if status_code == 200
    puts "=== access_token has been revoked successfully ==="
  else
    puts "=== access_token revoking failed ==="
  end
end

main
