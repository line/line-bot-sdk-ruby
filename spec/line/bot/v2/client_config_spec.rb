require 'spec_helper'
require 'base64'

describe 'Client configuration' do
  describe 'HTTP Request' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:user_id) { 'u1234567890' }
    let(:response_body) { { displayName: "LINE taro", userId: user_id, language: "en", pictureUrl: "https://profile.line-scdn.net/ch/v2/p/uf9da5ee2b...", statusMessage: "Hello, LINE!" }.to_json }
    let(:response_code) { 200 }

    it 'has correct User-Agent header' do
      path = "https://api.line.me/v2/bot/profile/#{user_id}"
      stub_request(:get, path)
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_profile_with_http_info(user_id: user_id)

      expect(status_code).to eq(response_code)
      expect(body.user_id).to eq(user_id)
      expect(WebMock).to have_requested(:get, path).
        with(headers: { 'User-Agent' => "LINE-BotSDK-Ruby/#{Line::Bot::VERSION}" })
    end
  end

  describe 'Unknown responses' do
    describe 'like unknown fields' do
      describe 'POST /v2/bot/message/reply' do
        let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
        let(:response_body) { { sentMessages: [{ id: "461230966842064897", quoteToken: "IStG5h1Tz7b..." }], invalidField: "foobar" }.to_json }
        let(:response_code) { 200 }

        it 'handles unknown fields in the response' do
          stub_request(:post, "https://api.line.me/v2/bot/message/reply")
            .with(
              headers: {
                'Authorization' => "Bearer test-channel-access-token",
                'Content-Type' => 'application/json'
              },
              body: anything
            )
            .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

          request = Line::Bot::V2::MessagingApi::ReplyMessageRequest.new(
            reply_token: 'test-reply-token',
            messages: [
              Line::Bot::V2::MessagingApi::TextMessage.new(
                text: 'Hello, world!'
              )
            ]
          )

          body, status_code, headers = client.reply_message_with_http_info(
            reply_message_request: request
          )

          expect(status_code).to eq(response_code)
          expect(body.invalid_field).to eq("foobar")
        end
      end
    end
  end

  describe 'Client.new - base_url' do
    describe 'normal client' do
      let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token', base_url: 'https://example.com') }
      let(:user_id) { 'u1234567890' }
      let(:response_body) { { displayName: "LINE taro", userId: user_id, language: "en", pictureUrl: "https://profile.line-scdn.net/ch/v2/p/uf9da5ee2b...", statusMessage: "Hello, LINE!" }.to_json }
      let(:response_code) { 200 }

      it 'allow to change base_url in normal client' do
        path = "https://example.com/v2/bot/profile/#{user_id}"
        stub_request(:get, path)
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_profile_with_http_info(user_id: user_id)

        expect(status_code).to eq(response_code)
        expect(body.user_id).to eq(user_id)
      end
    end

    describe 'blob client' do
      let(:client) { Line::Bot::V2::MessagingApi::ApiBlobClient.new(channel_access_token: 'test-channel-access-token', base_url: 'https://example.com') }
      let(:response_body) { { status: "succeeded" }.to_json }
      let(:response_code) { 200 }

      it 'allow to change base_url in blob client' do
        path = "https://example.com/v2/bot/message/test-message-id/content/transcoding"
        stub_request(:get, path)
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_message_content_transcoding_by_message_id_with_http_info(message_id: 'test-message-id')
        expect(status_code).to eq(200)
        expect(body.status).to eq('succeeded')
      end
    end

    describe 'module attach client' do
      let(:client) { Line::Bot::V2::ModuleAttach::ApiClient.new(base_url: 'https://example.com', channel_id: '100000', channel_secret: 'test-channel-secret') }
      let(:response_body) { { bot_id: "U111...", scopes: ["message:send", "message:receive"] }.to_json }
      let(:response_code) { 200 }

      it 'allow to change base_url in module attach client' do
        path = "https://example.com/module/auth/v1/token"
        expected_authorization_header_value = Base64.strict_encode64("100000:test-channel-secret")

        stub_request(:post, path)
          .with(
            headers: {
              'Authorization' => "Basic #{expected_authorization_header_value}",
              'Content-Type' => 'application/x-www-form-urlencoded'
            },
            body: {
              'grant_type' => 'authorization_code',
              'code' => 'test-code',
              'redirect_uri' => 'https://example2.com/callback?key=value',
              'scope' => 'message:send message:receive'
            }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.attach_module_with_http_info(
          grant_type: 'authorization_code',
          code: 'test-code',
          redirect_uri: 'https://example2.com/callback?key=value',
          scope: 'message:send message:receive'
        )
        expect(status_code).to eq(200)
        expect(body.bot_id).to eq('U111...')
        expect(body.scopes).to eq(["message:send", "message:receive"])
      end
    end
  end
end
