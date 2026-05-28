require 'spec_helper'

describe 'MessagingApi::ApiClient path parameters' do
  let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test_channel_access_token') }

  describe 'GET /v2/bot/profile/{userId} (get_profile)' do
    let(:user_id) { 'U0123456789abcdef0123456789abcdef' }
    let(:response_body) do
      { 'userId' => user_id, 'displayName' => 'Brown' }.to_json
    end

    it 'substitutes a plain user_id into the path' do
      stub_request(:get, "https://api.line.me/v2/bot/profile/#{user_id}")
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, _headers = client.get_profile_with_http_info(user_id: user_id)

      expect(status_code).to eq(200)
      expect(body.user_id).to eq(user_id)
      expect(body.display_name).to eq('Brown')
    end

    it 'rejects ".." passed as user_id' do
      # /v2/bot/profile/.. would otherwise normalize to /v2/bot/ and reach a
      # different endpoint.
      expect do
        client.get_profile_with_http_info(user_id: '..')
      end.to raise_error(ArgumentError, /path traversal/)
    end

    it 'percent-encodes a "../" value so the slash stays inside the user_id segment' do
      # If WebMock matches this stubbed URL, encoding worked. Without the fix
      # the request would target /v2/bot/profile/../message/quota literally,
      # which would not match the stub and WebMock would raise.
      stub_request(:get, 'https://api.line.me/v2/bot/profile/..%2Fmessage%2Fquota')
        .to_return(status: 200, body: { 'userId' => '../message/quota', 'displayName' => 'attacker' }.to_json,
                   headers: { 'Content-Type' => 'application/json' })

      _body, status_code, _headers = client.get_profile_with_http_info(user_id: '../message/quota')

      expect(status_code).to eq(200)
    end
  end

  describe 'GET /v2/bot/group/{groupId}/member/{userId} (get_group_member_profile)' do
    it 'substitutes both path parameters' do
      stub_request(:get, 'https://api.line.me/v2/bot/group/Ga123/member/Ub456')
        .to_return(status: 200, body: { 'displayName' => 'Brown', 'userId' => 'Ub456' }.to_json,
                   headers: { 'Content-Type' => 'application/json' })

      body, status_code, _headers = client.get_group_member_profile_with_http_info(
        group_id: 'Ga123',
        user_id: 'Ub456'
      )

      expect(status_code).to eq(200)
      expect(body.display_name).to eq('Brown')
      expect(body.user_id).to eq('Ub456')
    end

    it 'rejects a traversal value in any of the path parameters' do
      expect do
        client.get_group_member_profile_with_http_info(group_id: '..', user_id: 'Ub456')
      end.to raise_error(ArgumentError, /path traversal/)

      expect do
        client.get_group_member_profile_with_http_info(group_id: 'Ga123', user_id: '.')
      end.to raise_error(ArgumentError, /path traversal/)
    end
  end
end
