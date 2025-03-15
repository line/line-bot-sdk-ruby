require 'spec_helper'

describe 'misc' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

  describe 'Uploading' do
    describe 'Uploading' do
      describe 'POST /v2/bot/audienceGroup/upload/byFile' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiBlobClient.new(channel_access_token: channel_access_token) }
        let(:file_path) { 'spec/fixtures/line/bot/v2/sample_user_ids.txt' }
        let(:file) { File.open(file_path) }

        it 'uploads a file to the audience successfully' do
          stub_request(:put, "https://api-data.line.me/v2/bot/audienceGroup/upload/byFile")
            .with(
              headers: {
                'Authorization' => "Bearer #{channel_access_token}",
                'Content-Type' => %r{multipart/form-data} # webmock doesn't support multipart/form-data so we use regex
              }
            )
            .to_return(status: 202, body: '', headers: {})

          response_body, status_code, headers = client.add_user_ids_to_audience_with_http_info(
            file: file,
            audience_group_id: 1234,
            upload_description: 'Test Audience'
          )

          expect(status_code).to eq(202)
          expect(response_body).to be_empty
        end
      end

      describe 'POST /v2/bot/audienceGroup/upload' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiClient.new(channel_access_token: channel_access_token) }

        it 'uploads a json to the audience successfully' do
          create_audience_group_request = {
            description: 'Test Audience',
          }

          stub_request(:post, "https://api.line.me/v2/bot/audienceGroup/upload")
            .with(
              body: "{\"description\":\"Test Audience\"}",
              headers: {
                'Authorization'=>"Bearer #{channel_access_token}",
                'Content-Type'=>'application/json',
              }
            )
            .to_return(status: 202, body: "", headers: {})

          response_body, status_code, headers = client.create_audience_group_with_http_info(
            create_audience_group_request: create_audience_group_request
          )

          expect(status_code).to eq(202)
          expect(response_body).to be_empty
        end
      end

      describe 'POST /v2/bot/richmenu/{richMenuId}/content' do
        let(:client) { Line::Bot::V2::MessagingApi::ApiBlobClient.new(channel_access_token: channel_access_token) }
        let(:rich_menu_id) { 'test-rich-menu-id' }
        let(:image_path) { 'spec/fixtures/line/bot/v2/test-image.jpeg' }
        let(:image_file) { File.open(image_path, 'rb') }

        it 'uploads an image to the rich menu successfully' do
          stub_request(:post, "https://api-data.line.me/v2/bot/richmenu/#{rich_menu_id}/content")
            .with(
              headers: {
                'Authorization' => "Bearer #{channel_access_token}",
                'Content-Type' => 'image/jpeg' # webmock doesn't support specific image content types so we use regex
              }
            )
            .to_return(status: 200, body: 'Success', headers: { 'Content-Type' => 'application/json' })

          response_body, status_code, headers = client.set_rich_menu_image_with_http_info(
            rich_menu_id: rich_menu_id,
            body: image_file
          )

          expect(status_code).to eq(200)
        end
      end
    end
  end

  describe 'Downloading' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiBlobClient.new(channel_access_token: channel_access_token) }
    let(:message_id) { 'test-message-id' }
    let(:rich_menu_id) { 'test-rich-menu-id' }
    let(:response_body) { 'binary data' }
    let(:response_code) { 200 }

    describe 'GET /v2/bot/message/{messageId}/content' do
      it 'downloads a message content successfully' do
        stub_request(:get, "https://api-data.line.me/v2/bot/message/#{message_id}/content/transcoding")
          .with(
            headers: {
              'Authorization' => "Bearer #{channel_access_token}",
            }
          )
          .to_return(status: response_code, body: { "status" => "ready" }.to_json, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_message_content_transcoding_by_message_id_with_http_info(
          message_id: message_id
        )

        expect(status_code).to eq(200)
        expect(body.status).to eq('ready')
      end
    end

    describe 'GET /v2/bot/richmenu/{richMenuId}/content' do
      it 'downloads a rich menu image successfully' do
        stub_request(:get, "https://api-data.line.me/v2/bot/richmenu/#{rich_menu_id}/content")
          .with(
            headers: {
              'Authorization' => "Bearer #{channel_access_token}",
            }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'image/jpeg' })

        body, status_code, headers = client.get_rich_menu_image_with_http_info(
          rich_menu_id: rich_menu_id
        )

        expect(status_code).to eq(200)
        expect(body).to eq('binary data')
      end
    end
  end

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
          body: {"clientId"=>"test-client-id", "clientSecret"=>"test-client-secret", "grantType"=>"client_credentials" }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.issue_channel_token_with_http_info(
        grant_type: grant_type,
        client_id: client_id,
        client_secret: client_secret
      )

      expect(status_code).to eq(200)
      expect(body.access_token).to eq('test-access-token')
    end
  end

  describe 'GET /v2/bot/followers/ids' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { { "user_ids" => ["U1234567890", "U0987654321"] }.to_json }
    let(:response_code) { 200 }

    it 'returns a list of followers successfully without optional parameters' do
      stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
    end
  end

  describe 'GET /v2/bot/message/aggregation/list' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { { "custom_aggregation_units" => ["unit1", "unit2"], "next" => "token" }.to_json }
    let(:response_code) { 200 }

    it 'returns a list of aggregation units successfully without optional parameters' do
      stub_request(:get, "https://api.line.me/v2/bot/message/aggregation/list")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_aggregation_unit_name_list_with_http_info

      expect(status_code).to eq(200)
      expect(body.custom_aggregation_units).to eq(["unit1", "unit2"])
      expect(body._next).to eq("token")
    end
  end

  describe 'POST /v2/bot/message/push' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { { "sentMessages" => [{ "id" => "461230966842064897", "quoteToken" => "IStG5h1Tz7b..." }] } }
    let(:response_code) { 200 }
    let(:x_line_retry_key) { SecureRandom.uuid }
    let(:request_body) do
      {
        "to" => "U4af4980629",
        "messages" => [
          {
            "type" => "text",
            "text" => "Hello, world1"
          }
        ]
      }
    end

    it 'returns a sentMessages id' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            "Authorization" => "Bearer test-channel-access-token",
            "X-Line-Retry-Key" => x_line_retry_key
          },
          body: request_body.to_json
        )
        .to_return(status: response_code, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.push_message_with_http_info(push_message_request: request_body, x_line_retry_key: x_line_retry_key)

      expect(status_code).to eq(200)
      expect(body.sent_messages).to eq([{ id: "461230966842064897", quote_token: "IStG5h1Tz7b..." }])
    end
  end
end
