require 'spec_helper'

describe 'ChannelAccessToken::ApiClient query parameter names' do
  let(:client) { Line::Bot::V2::ChannelAccessToken::ApiClient.new }

  describe 'GET /oauth2/v2.1/verify (verify_channel_token_by_jwt)' do
    let(:access_token) { 'test_access_token_value' }
    let(:response_body) do
      { "clientId" => "1234567890", "expiresIn" => 12345 }.to_json
    end

    it 'sends access_token as snake_case query key, not accessToken' do
      # Exact query match: passes only when the key is "access_token" (snake_case).
      # If camelCase "accessToken" were used instead, the stub would not match and
      # WebMock would raise an error, failing the test.
      stub_request(:get, "https://api.line.me/oauth2/v2.1/verify")
        .with(query: { "access_token" => access_token })
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, _headers = client.verify_channel_token_by_jwt_with_http_info(
        access_token: access_token
      )

      expect(status_code).to eq(200)
      expect(body.client_id).to eq("1234567890")
      expect(body.expires_in).to eq(12345)
    end
  end

  describe 'GET /oauth2/v2.1/tokens/kid (gets_all_valid_channel_access_token_key_ids)' do
    let(:client_assertion_type) { 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer' }
    let(:client_assertion) { 'test_jwt_assertion' }
    let(:response_body) do
      { "kids" => ["kid1", "kid2"] }.to_json
    end

    it 'sends client_assertion_type and client_assertion as snake_case query keys, not camelCase' do
      # Exact query match: passes only when the keys are "client_assertion_type" and
      # "client_assertion" (snake_case). If camelCase were used, the stub would not match.
      expected_query = {
        "client_assertion_type" => client_assertion_type,
        "client_assertion" => client_assertion
      }
      stub_request(:get, "https://api.line.me/oauth2/v2.1/tokens/kid")
        .with(query: expected_query)
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, _headers = client.gets_all_valid_channel_access_token_key_ids_with_http_info(
        client_assertion_type: client_assertion_type,
        client_assertion: client_assertion
      )

      expect(status_code).to eq(200)
      expect(body.kids).to eq(["kid1", "kid2"])
    end
  end
end
