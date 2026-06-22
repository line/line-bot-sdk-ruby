require 'spec_helper'

describe 'ChannelAccessToken' do
  describe 'POST /v2/oauth/accessToken' do
    let(:client) { Line::Bot::V2::ChannelAccessToken::ApiClient.new }
    let(:grant_type) { 'client_credentials' }
    let(:client_id) { 'test-client-id' }
    let(:client_secret) { 'test-client-secret' }
    let(:response_body) { { "access_token" => "test-access-token", "expires_in" => 2592000 }.to_json }
    let(:response_code) { 200 }

    it "doesn't require bearer token" do
      stub_request(:post, "https://api.line.me/v2/oauth/accessToken")
        .with(
          body: { client_id: "test-client-id", client_secret: "test-client-secret", grant_type: "client_credentials" },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.issue_channel_token_with_http_info(
        grant_type: grant_type,
        client_id: client_id,
        client_secret: client_secret
      )

      expect(status_code).to eq(200)
      expect(body.access_token).to eq('test-access-token')

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/oauth/accessToken")
                            .with { |req| !req.headers.key?("Authorization") })
    end
  end

  describe 'POST /oauth2/v3/token' do
    let(:client) { Line::Bot::V2::ChannelAccessToken::ApiClient.new }
    let(:grant_type) { 'client_credentials' }
    let(:client_id) { 'test-client-id' }
    let(:client_secret) { 'test-client-secret' }
    let(:response_body) { { "access_token" => "test-access-token", "expires_in" => 2592000, "token_type" => "Bearer" }.to_json }
    let(:response_code) { 200 }

    it "when the two parameters are nil, they will not be sent" do
      stub_request(:post, "https://api.line.me/oauth2/v3/token")
        .with(
          body: { client_id: "test-client-id", client_secret: "test-client-secret", grant_type: "client_credentials" },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.issue_stateless_channel_token_with_http_info(
        grant_type: grant_type,
        client_id: client_id,
        client_secret: client_secret
      )

      expect(status_code).to eq(200)
      expect(body.access_token).to eq('test-access-token')
      expect(body.token_type).to eq('Bearer')

      expect(WebMock).to(have_requested(:post, "https://api.line.me/oauth2/v3/token")
                           .with { |req| !req.headers.key?("Authorization") })
    end
  end

  describe 'issue_stateless_channel_token_by_jwt_assertion' do
    let(:client) { Line::Bot::V2::ChannelAccessToken::ApiClient.new }
    let(:client_assertion) { 'eyJhbGciOiJSUzI.dummy' }
    let(:response_body) { { "access_token" => "test-access-token", "expires_in" => 900, "token_type" => "Bearer" }.to_json }
    let(:response_code) { 200 }

    it "sends only JWT assertion parameters" do
      stub_request(:post, "https://api.line.me/oauth2/v3/token")
        .with(
          body: {
            grant_type: "client_credentials",
            client_assertion_type: "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
            client_assertion: client_assertion
          },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body = client.issue_stateless_channel_token_by_jwt_assertion(
        client_assertion: client_assertion
      )

      expect(body.access_token).to eq('test-access-token')
      expect(body.token_type).to eq('Bearer')
    end
  end

  describe 'issue_stateless_channel_token_by_client_secret' do
    let(:client) { Line::Bot::V2::ChannelAccessToken::ApiClient.new }
    let(:client_id) { 'test-client-id' }
    let(:client_secret) { 'test-client-secret' }
    let(:response_body) { { "access_token" => "test-access-token", "expires_in" => 900, "token_type" => "Bearer" }.to_json }
    let(:response_code) { 200 }

    it "sends only client secret parameters" do
      stub_request(:post, "https://api.line.me/oauth2/v3/token")
        .with(
          body: {
            grant_type: "client_credentials",
            client_id: client_id,
            client_secret: client_secret
          },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body = client.issue_stateless_channel_token_by_client_secret(
        client_id: client_id,
        client_secret: client_secret
      )

      expect(body.access_token).to eq('test-access-token')
      expect(body.token_type).to eq('Bearer')
    end
  end
end
