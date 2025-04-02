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
                'Authorization' => "Bearer #{channel_access_token}",
                'Content-Type' => 'application/json',
              }
            )
            .to_return(status: 202, body: "{\"description\": \"Test Audience response\"}", headers: {})

          response_body, status_code, headers = client.create_audience_group_with_http_info(
            create_audience_group_request: create_audience_group_request
          )

          expect(status_code).to eq(202)
          expect(response_body.description).to eq('Test Audience response')
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

  describe 'GET /v2/bot/insight/followers' do
    let(:client) { Line::Bot::V2::Insight::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_code) { 200 }

    it 'returns the number of followers successfully (ready status)' do
      response_body = {
        "status" => "ready",
        "followers" => 1000,
        "targetedReaches" => 900,
        "blocks" => 100
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, = client.get_number_of_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.status).to eq('ready')
      expect(body.followers).to eq(1000)
      expect(body.targeted_reaches).to eq(900)
      expect(body.blocks).to eq(100)
    end

    it 'handles the null fields properly (unready status)' do
      response_body = {
        "status" => "unready",
        "followers" => nil,
        "targetedReaches" => nil,
        "blocks" => nil
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, = client.get_number_of_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.status).to eq('unready')
      expect(body.followers).to be_nil
      expect(body.targeted_reaches).to be_nil
      expect(body.blocks).to be_nil
    end
  end

  describe 'GET /v2/bot/message/progress/narrowcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_body) do
      # missing errorCode, completedTime, targetCount
      {
        "phase" => "waiting",
        "acceptedTime" => "2020-12-03T10:15:30.121Z"
      }
        .to_json
    end
    let(:response_code) { 200 }

    it 'no problem even when response does not contain some JSON keys' do
      stub_request(:get, "https://api.line.me/v2/bot/message/progress/narrowcast?requestId=7d51557c-7ba0-4ed7-991f-36b2a340dc1a")
        .with(
          headers: {
            'Authorization'=>'Bearer YOUR_CHANNEL_ACCESS_TOKEN',
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'x-line-request-id' => '3a785346-2cf3-482f-8469-c893117fcef8' })

      body, status_code, headers = client.get_narrowcast_progress_with_http_info(
        request_id: '7d51557c-7ba0-4ed7-991f-36b2a340dc1a'
      )

      expect(status_code).to eq(200)
      expect(body.phase).to eq('waiting')
      expect(body.accepted_time).to eq('2020-12-03T10:15:30.121Z')
      expect(body.error_code).to be_nil
      expect(body.completed_time).to be_nil
      expect(body.target_count).to be_nil
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
          body: { "clientId" => "test-client-id", "clientSecret" => "test-client-secret", "grantType" => "client_credentials" }
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
    let(:response_code) { 200 }

    it 'returns a list of followers successfully without optional parameters' do
      response_body = { "user_ids" => ["U1234567890", "U0987654321"] }.to_json
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

    it 'query with only start' do
      response_body = { "user_ids" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json
      stub_request(:get, "https://api.line.me/v2/bot/followers/ids?start=from%20previous%20NEXT")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT")

      expect(status_code).to eq(200)
      expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
      expect(body._next).to eq("nExT Token")
    end

    it 'query with limit and start' do
      response_body = { "user_ids" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json
      stub_request(:get, "https://api.line.me/v2/bot/followers/ids?limit=10&start=from%20previous%20NEXT")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT", limit: 10)

      expect(status_code).to eq(200)
      expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
      expect(body._next).to eq("nExT Token")
    end
  end

  describe 'PUT /liff/v1/apps/{liffId}' do
    let(:client) { Line::Bot::V2::Liff::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { "" } # not empty json, but empty string
    let(:response_code) { 200 }

    it 'empty response body should not throw error' do
      stub_request(:put, "https://api.line.me/liff/v1/apps/test-liff-id")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: {  })

      request = Line::Bot::V2::Liff::UpdateLiffAppRequest.new(view: { url: 'https://example.com' })
      body, status_code, headers = client.update_liff_app_with_http_info(liff_id: 'test-liff-id', update_liff_app_request: request)

      expect(status_code).to eq(200)
      expect(body).to eq("")
    end
  end

  describe 'POST /v2/bot/message/broadcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { {  }.to_json } # empty json
    let(:response_code) { 200 }

    it 'empty json as response body should not throw error' do
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: { type: 'text', text: 'Hello, world!' })

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
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

  describe 'Line::Bot::V2::MessagingApi::TemplateMessage#initialize' do
    it "contains fixed type attribute" do
      template_message = Line::Bot::V2::MessagingApi::TemplateMessage.new(
        alt_text: 'Test Alt Text',
        template: Line::Bot::V2::MessagingApi::ButtonsTemplate.new(
          text: 'Test Text',
          actions: [],
          title: 'Test Title'
        )
      )

      expect(template_message.type).to eq('template')
    end
  end
end
