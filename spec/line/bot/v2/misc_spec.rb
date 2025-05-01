require 'spec_helper'
require 'base64'

describe 'misc' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

  describe 'Uploading' do
    describe 'Uploading' do
      describe 'PUT /v2/bot/audienceGroup/upload/byFile' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiBlobClient.new(channel_access_token: channel_access_token) }
        let(:file_path) { 'spec/fixtures/line/bot/v2/sample_user_ids.txt' }
        let(:file) { File.open(file_path) }

        it 'uploads a file to the audience successfully' do
          stub_request(:put, "https://api-data.line.me/v2/bot/audienceGroup/upload/byFile")
            .with do |request|
            expect(request.headers['Authorization']).to eq("Bearer #{channel_access_token}")
            # Ensure it's multipart/form-data (with boundary)
            expect(request.headers['Content-Type']).to match(%r{\Amultipart/form-data; boundary=.+})

            # Check if 'uploadDescription' part exists
            expect(request.body).to include('Content-Disposition: form-data; name="uploadDescription"')
            expect(request.body).to include('Test Audience')

            # Check if 'audienceGroupId' part exists
            expect(request.body).to include('Content-Disposition: form-data; name="audienceGroupId"')
            expect(request.body).to include('1234')

            # file part
            expect(request.body).to include('Content-Disposition: form-data; name="file"; filename="sample_user_ids.txt"')
            # body must contain content type text/plain
            expect(request.body).to include('Content-Type: text/plain')
            expect(request.body).to include('U4af4980627')
            expect(request.body).to include('U4af4980628')
          end
            .to_return(status: 202, body: '{}', headers: {})

          response_body, status_code, headers = client.add_user_ids_to_audience_with_http_info(
            file: file,
            audience_group_id: 1234,
            upload_description: 'Test Audience'
          )

          expect(status_code).to eq(202)
          expect(response_body).to eq("{}")
        end
      end

      describe 'POST /v2/bot/audienceGroup/upload/byFile' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiBlobClient.new(channel_access_token: channel_access_token) }
        let(:file_path) { 'spec/fixtures/line/bot/v2/sample_user_ids.txt' }
        let(:file) { File.open(file_path) }
        let(:response_body) do
          {
            "audienceGroupId": 1234567890123,
            "createRoute": "MESSAGING_API",
            "type": "UPLOAD",
            "description": "audienceGroupName_01",
            "created": 1613700237,
            "permission": "READ_WRITE",
            "expireTimestamp": 1629252237,
            "isIfaAudience": false
          }.to_json
        end

        it 'uploads a file to the audience successfully' do
          stub_request(:post, "https://api-data.line.me/v2/bot/audienceGroup/upload/byFile")
            .with do |request|
            expect(request.headers['Authorization']).to eq("Bearer #{channel_access_token}")
            # Ensure it's multipart/form-data (with boundary)
            expect(request.headers['Content-Type']).to match(%r{\Amultipart/form-data; boundary=.+})

            # Check if 'uploadDescription' part exists
            expect(request.body).to include('Content-Disposition: form-data; name="uploadDescription"')
            expect(request.body).to include('Test Audience')

            # file part
            expect(request.body).to include('Content-Disposition: form-data; name="file"; filename="sample_user_ids.txt"')
            # body must contain content type text/plain
            expect(request.body).to include('Content-Type: text/plain')
            expect(request.body).to include('U4af4980627')
            expect(request.body).to include('U4af4980628')
          end
            .to_return(status: 202, body: response_body, headers: {})

          body, status_code, headers = client.create_audience_for_uploading_user_ids_with_http_info(
            file: file,
            upload_description: 'Test Audience'
          )

          expect(status_code).to eq(202)
          expect(body.audience_group_id).to eq(1234567890123)
        end
      end

      describe 'POST /v2/bot/audienceGroup/upload' do
        let(:client) { Line::Bot::V2::ManageAudience::ApiClient.new(channel_access_token: channel_access_token) }

        it 'uploads a json to the audience successfully' do
          create_audience_group_request = Line::Bot::V2::ManageAudience::CreateAudienceGroupRequest.new(
            description: 'Test Audience'
          )
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
                'Content-Type' => 'image/jpeg'
              }
            )
            .to_return(status: 200, body: '{}', headers: { 'Content-Type' => 'application/json' })

          response_body, status_code, headers = client.set_rich_menu_image_with_http_info(
            rich_menu_id: rich_menu_id,
            body: image_file
          )

          expect(status_code).to eq(200)
          expect(response_body).to eq("{}")
          expect(headers['Content-Type']).to eq(nil)
          expect(headers['content-type']).to eq('application/json')
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
          .to_return(status: response_code, body: { "status" => "processing" }.to_json, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_message_content_transcoding_by_message_id_with_http_info(
          message_id: message_id
        )

        expect(status_code).to eq(200)
        expect(body.status).to eq('processing')
        expect(headers['content-type']).to eq('application/json')
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
        expect(headers['content-type']).to eq('image/jpeg')
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
            'Authorization' => 'Bearer YOUR_CHANNEL_ACCESS_TOKEN',
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

  describe 'GET /v2/bot/followers/ids' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_code) { 200 }

    context 'when no optional parameters given' do
      it 'returns a list of followers successfully (strict check without any query params)' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"] }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            },
            query: {}
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_followers_with_http_info

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
      end
    end

    context 'when only start parameter is given' do
      it 'returns a list of followers with next token (strict check with only "start")' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "start" => "from previous NEXT" }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT")

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
        expect(body._next).to eq("nExT Token")
      end
    end

    context 'when limit and start parameters are both given' do
      it 'returns a list of followers with next token (strict check with "limit" and "start")' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "limit" => "10", "start" => "from previous NEXT" }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT", limit: 10)

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
        expect(body._next).to eq("nExT Token")
      end
    end

    context 'when making two consecutive requests in one test' do
      it 'handles two requests, first with the same params and second with different params' do
        first_response_body = {
          "userIds" => ["U1111111111", "U2222222222"],
          "next" => "firstNextToken"
        }.to_json
        second_response_body = {
          "userIds" => ["U3333333333", "U4444444444"],
        }.to_json

        # First request: using start="from previous NEXT", limit=10
        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "start" => "from previous NEXT", "limit" => "10" }
          )
          .to_return(
            status: 200,
            body: first_response_body,
            headers: { 'Content-Type' => 'application/json' }
          )

        # Second request: using start="anotherParam", limit=5
        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "start" => "anotherParam", "limit" => "5" }
          )
          .to_return(
            status: 200,
            body: second_response_body,
            headers: { 'Content-Type' => 'application/json' }
          )

        # ---- First access ----
        body1, status_code1, headers1 = client.get_followers_with_http_info(start: "from previous NEXT", limit: 10)
        expect(status_code1).to eq(200)
        expect(body1.user_ids).to eq(["U1111111111", "U2222222222"])
        expect(body1._next).to eq("firstNextToken")

        # ---- Second access ----
        body2, status_code2, headers2 = client.get_followers_with_http_info(start: "anotherParam", limit: 5)
        expect(status_code2).to eq(200)
        expect(body2.user_ids).to eq(["U3333333333", "U4444444444"])
        expect(body2._next).to be_nil
      end
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
        .to_return(status: response_code, body: response_body, headers: {})

      request = Line::Bot::V2::Liff::UpdateLiffAppRequest.new(view: { url: 'https://example.com' })
      body, status_code, headers = client.update_liff_app_with_http_info(liff_id: 'test-liff-id', update_liff_app_request: request)

      expect(status_code).to eq(200)
      expect(body).to eq("")
    end
  end

  describe 'POST /v2/bot/message/push' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) do
      {
        "sentMessages": [
          {
            "id": "461230966842064897",
            "quoteToken": "IStG5h1Tz7b..."
          }
        ]
      }.to_json
    end
    let(:response_code) { 200 }

    it 'response - success - using Line::Bot::V2::MessagingApi::PushMessageRequest' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => " Hello, world! "
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: ' Hello, world! '
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'response - success - using hash (not recommended way)', rbs_test: :skip do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => " Hello, world! "
              }
            ],
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = {
        "to" => "USER_ID",
        "messages" => [{ type: 'text', text: ' Hello, world! ' }]
      }
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
    end

    it 'request - text message v2' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "textV2",
                "text" => " Hello, world! {user_name} san!",
                "substitution" => {
                  "user_name" => {
                    "type" => "mention",
                    "mentionee" => {
                      "type" => "user",
                      "userId" => "U1234567890"
                    }
                  }
                }
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessageV2.new(
            text: 'Hello, world! {user_name} san!',
            substitution: {
              "user_name": Line::Bot::V2::MessagingApi::MentionSubstitutionObject.new(
                mentionee: Line::Bot::V2::MessagingApi::UserMentionTarget.new(
                  user_id: 'U1234567890'
                )
              )
            }
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'request with x_line_retry_key: nil' do
      client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token-retry-key-nil')
      retry_key = nil
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token-retry-key-nil",
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      client.push_message_with_http_info(
        push_message_request: request,
        x_line_retry_key: retry_key
      )

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/bot/message/push")
                           .with { |req| !req.headers.key?("X-Line-Retry-Key") })
    end

    it 'request with x-line-retry-key header - success' do
      retry_key = 'f03c3eb4-0267-4080-9e65-fffa184e1933'
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(
        push_message_request: request,
        x_line_retry_key: retry_key
      )
      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'request with  x-line-retry-key header - conflicted' do
      retry_key = '2a6e07b0-0fcf-439f-908b-828ed527e882'
      request_id = '3a785346-2cf3-482f-8469-c893117fcef8'
      accepted_request_id = '4a6e07b0-0fcf-439f-908b-828ed527e882'

      error_response_body = {
        "message" => "The retry key is already accepted",
        "sentMessages" => [
          {
            "id" => "461230966842064897",
            "quoteToken" => "IStG5h1Tz7b..."
          }
        ]
      }.to_json
      error_response_headers = {
        'Content-Type' => 'application/json',
        'x-line-request-id' => request_id,
        'x-line-accepted-request-id' => accepted_request_id
      }
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: 409, body: error_response_body, headers: error_response_headers)

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(
        push_message_request: request,
        x_line_retry_key: retry_key
      )
      expect(status_code).to eq(409)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::ErrorResponse)
      expect(body.message).to eq("The retry key is already accepted")
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
      expect(headers['x-line-request-id']).to eq(request_id)
      expect(headers['x-line-accepted-request-id']).to eq(accepted_request_id)
    end
  end

  describe 'POST /v2/bot/message/broadcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { {}.to_json } # empty json
    let(:response_code) { 200 }

    it 'empty json as response body should not throw error' do
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )

      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: request)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end

    it 'request with x_line_retry_key: nil' do
      client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token-retry-key-nil')
      retry_key = nil
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token-retry-key-nil",
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      client.broadcast_with_http_info(broadcast_request: request, x_line_retry_key: retry_key)

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/bot/message/broadcast")
                           .with { |req| !req.headers.key?("X-Line-Retry-Key") })
    end

    it 'request with  x-line-retry-key header - success' do
      retry_key = 'f03c3eb4-0267-4080-9e65-fffa184e1933'
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: request, x_line_retry_key: retry_key)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end

    it 'request with  x-line-retry-key header - conflicted' do
      retry_key = '2a6e07b0-0fcf-439f-908b-828ed527e882'
      request_id = '3a785346-2cf3-482f-8469-c893117fcef8'
      accepted_request_id = '4a6e07b0-0fcf-439f-908b-828ed527e882'

      error_response_body = { "message" => "The retry key is already accepted" }.to_json
      error_response_headers = {
        'Content-Type' => 'application/json',
        'x-line-request-id' => request_id,
        'x-line-accepted-request-id' => accepted_request_id
      }
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: 409, body: error_response_body, headers: error_response_headers)

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: request, x_line_retry_key: retry_key)

      expect(status_code).to eq(409)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::ErrorResponse)
      expect(body.message).to eq("The retry key is already accepted")
      expect(headers['x-line-request-id']).to eq(request_id)
      expect(headers['x-line-accepted-request-id']).to eq(accepted_request_id)
    end
  end

  describe 'GET /v2/bot/message/aggregation/list' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { { "customAggregationUnits" => ["unit1", "unit2"], "next" => "token" }.to_json }
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

  describe 'Same endpoint but different HTTP method' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:rich_menu_id) { "richmenuid" }

    describe 'GET /v2/bot/user/all/richmenu' do
      let(:response_body) { { richMenuId: rich_menu_id }.to_json }
      let(:response_code) { 200 }

      it 'returns a default rich menu ID successfully' do
        stub_request(:get, "https://api.line.me/v2/bot/user/all/richmenu")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: response_body, headers: {})

        body, status_code, headers = client.get_default_rich_menu_id_with_http_info

        expect(status_code).to eq(response_code)
        expect(body.rich_menu_id).to eq(rich_menu_id)
      end
    end

    describe 'POST /v2/bot/user/all/richmenu' do
      let(:response_body) { {}.to_json }
      let(:response_code) { 200 }

      it 'sets the default rich menu successfully' do
        stub_request(:post, "https://api.line.me/v2/bot/user/all/richmenu/#{rich_menu_id}")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: '{}', headers: {})

        body, status_code, headers = client.set_default_rich_menu_with_http_info(rich_menu_id: rich_menu_id)

        expect(status_code).to eq(response_code)
        expect(body).to eq(response_body)
      end
    end

    describe 'DELETE /v2/bot/user/all/richmenu' do
      let(:response_body) { {}.to_json }
      let(:response_code) { 200 }

      it 'deletes the default rich menu successfully' do
        stub_request(:delete, "https://api.line.me/v2/bot/user/all/richmenu")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: '{}', headers: {})

        # Call the API method
        body, status_code, headers = client.cancel_default_rich_menu_with_http_info

        # Assertions
        expect(status_code).to eq(200)
        expect(body).to eq(response_body)
      end
    end
  end

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

  describe 'Line::Bot::V2::MessagingApi::DatetimePickerAction#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates DatetimePickerAction with minimal required fields and broadcasts correctly' do
      text_message = Line::Bot::V2::MessagingApi::TextMessage.new(
        text: "Please pick a date/time!",
        quick_reply: Line::Bot::V2::MessagingApi::QuickReply.new(
          items: [
            Line::Bot::V2::MessagingApi::QuickReplyItem.new(
              action: Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                data: 'some_data',
                mode: 'datetime',
                label: 'Pick'
              )
            )
          ]
        )
      )

      expected_body = {
        messages: [
          {
            type: 'text',
            text: "Please pick a date/time!",
            quickReply: {
              items: [
                {
                  type: 'action',
                  action: {
                    type: 'datetimepicker', # important: this is the fixed type
                    data: 'some_data',
                    mode: 'datetime',
                    label: 'Pick'
                  }
                }
              ]
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [text_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::RichMenuSwitchAction#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates RichMenuSwitchAction with minimal required fields and broadcasts correctly' do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: "Switch RichMenu",
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexButton.new(
                action: Line::Bot::V2::MessagingApi::RichMenuSwitchAction.new(
                  data: 'switch_richmenu',
                  rich_menu_alias_id: 'alias_xxx',
                  label: 'Switch Menu'
                )
              )
            ]
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Switch RichMenu',
            contents: {
              type: 'bubble',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'button',
                    action: {
                      type: 'richmenuswitch', # important: this is the fixed type
                      data: 'switch_richmenu',
                      richMenuAliasId: 'alias_xxx',
                      label: 'Switch Menu'
                    }
                  }
                ]
              }
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::ImageCarouselTemplate#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates ImageCarouselTemplate with minimal required fields and broadcasts correctly' do
      template_message = Line::Bot::V2::MessagingApi::TemplateMessage.new(
        alt_text: "This is an Image Carousel",
        template: Line::Bot::V2::MessagingApi::ImageCarouselTemplate.new(
          columns: [
            Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
              image_url: 'https://example.com/image1.png',
              action: Line::Bot::V2::MessagingApi::URIAction.new(
                uri: 'https://example.com',
                label: 'Go'
              )
            ),
            Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
              image_url: 'https://example.com/image2.png',
              action: Line::Bot::V2::MessagingApi::MessageAction.new(
                text: 'Hello!',
                label: 'Say Hello'
              )
            )
          ]
        )
      )

      expected_body = {
        messages: [
          {
            type: 'template',
            altText: 'This is an Image Carousel',
            template: {
              type: 'image_carousel', # important: this is the fixed type
              columns: [
                {
                  imageUrl: 'https://example.com/image1.png',
                  action: {
                    type: 'uri',
                    uri: 'https://example.com',
                    label: 'Go'
                  }
                },
                {
                  imageUrl: 'https://example.com/image2.png',
                  action: {
                    type: 'message',
                    text: 'Hello!',
                    label: 'Say Hello'
                  }
                }
              ]
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [template_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::FlexBoxLinearGradient#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates FlexBox with linearGradient background and broadcasts correctly' do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: 'Test FlexBox with LinearGradient',
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexText.new(text: 'Hello World!')
            ],
            background: Line::Bot::V2::MessagingApi::FlexBoxLinearGradient.new(
              angle: '90deg',
              start_color: '#FF0000',
              end_color: '#0000FF'
            )
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Test FlexBox with LinearGradient',
            contents: {
              type: 'bubble',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'text',
                    text: 'Hello World!'
                  }
                ],
                background: {
                  type: 'linearGradient', # important: this is the fixed type
                  angle: '90deg',
                  startColor: '#FF0000',
                  endColor: '#0000FF'
                }
              }
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::FlexMessage#initialize - simple flex text' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it "contains fixed type attribute (check in request body), and optional fields don't require input on initialize" do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: 'Test Alt Text',
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new( # FlexBubble has many optional fields
          direction: 'ltr',
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexText.new(
                text: 'Test Text',
                weight: 'bold'
              )
            ]
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Test Alt Text',
            contents: {
              type: 'bubble',
              direction: 'ltr',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'text',
                    text: 'Test Text',
                    weight: 'bold'
                  }
                ]
              }
            }
          }
        ],
        notificationDisabled: false
      }.to_json

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: expected_body
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message]))
    end
  end

  describe 'Line::Bot::V2::MessagingApi::FlexMessage#initialize - do not drop empty array' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it "contains fixed type attribute (check in request body), and optional fields don't require input on initialize" do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: 'Test Alt Text',
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new( # FlexBubble has many optional fields
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexText.new(
                text: 'Test Text',
                weight: 'bold'
              ),
              Line::Bot::V2::MessagingApi::FlexImage.new(
                url: 'https://example.com/flex/images/image.jpg'
              ),
              Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [], # important: We must send this empty array, because Messaging API requires it
                width: '30px',
                height: '30px',
                background: Line::Bot::V2::MessagingApi::FlexBoxLinearGradient.new(
                  angle: '90deg',
                  start_color: '#FFFF00',
                  end_color: '#0080ff'
                )
              )
            ]
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Test Alt Text',
            contents: {
              type: 'bubble',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'text',
                    text: 'Test Text',
                    weight: 'bold'
                  },
                  {
                    "type": "image",
                    "url": "https://example.com/flex/images/image.jpg",
                    "size": "md",
                    "animated": false
                  },
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [],
                    "width": "30px",
                    "height": "30px",
                    "background": {
                      "type": "linearGradient",
                      "angle": "90deg",
                      "startColor": "#FFFF00",
                      "endColor": "#0080ff"
                    }
                  }
                ]
              }
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message]))
    end
  end

  describe 'Line::Bot::V2::Insight::AgeTile#initialize' do
    it 'creates AgeTile correctly' do
      age_tile = Line::Bot::V2::Insight::AgeTile.new(
        age: 'from15to19',
        percentage: 50.0
      )

      expect(age_tile.age).to eq('from15to19')
      expect(age_tile.percentage).to eq(50.0)
    end

    context 'with invalid enum value' do
      it "doesn't raise any error" do
        age_tile = Line::Bot::V2::Insight::AgeTile.new(
          age: 'unknown', # invalid value
          percentage: 50.0
        )

        expect(age_tile.age).to eq('unknown')
        expect(age_tile.percentage).to eq(50.0)
      end
    end
  end

  describe 'Line::Bot::V2::Liff::LiffApp#initialize' do
    it 'creates LiffApp correctly' do
      liff_app = Line::Bot::V2::Liff::LiffApp.new(
        liff_id: 'liffId123',
        view: Line::Bot::V2::Liff::LiffView.new(
          type: 'full',
          url: 'https://example.com'
        ),
        description: 'Test Liff App',
        permanent_link_pattern: 'openid',
        bot_prompt: 'normal'
      )

      expect(liff_app.liff_id).to eq('liffId123')
      expect(liff_app.view.type).to eq('full')
      expect(liff_app.view.url).to eq('https://example.com')
      expect(liff_app.description).to eq('Test Liff App')
      expect(liff_app.permanent_link_pattern).to eq('openid')
      expect(liff_app.bot_prompt).to eq('normal')
    end

    context 'with invalid enum values' do
      it "doesn't raise any error", rbs_test: :skip do
        liff_app = Line::Bot::V2::Liff::LiffApp.new(
          liff_id: 'liffId123',
          view: Line::Bot::V2::Liff::LiffView.new(
            type: 'unknown', # invalid value
            url: 'https://example.com'
          ),
          description: 'Test Liff App',
          permanent_link_pattern: 'unknown', # invalid value
          bot_prompt: 'unknown' # invalid value
        )

        expect(liff_app.liff_id).to eq('liffId123')
        expect(liff_app.view.type).to eq('unknown')
        expect(liff_app.view.url).to eq('https://example.com')
        expect(liff_app.description).to eq('Test Liff App')
        expect(liff_app.permanent_link_pattern).to eq('unknown')
        expect(liff_app.bot_prompt).to eq('unknown')
      end
    end
  end

  describe '#==' do
    context 'with simple objects' do
      context 'with other class (but same origin)' do
        it 'returns false' do
          obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
          obj2 = Line::Bot::V2::MessagingApi::TextMessageV2.new(text: 'Hello')
          expect(obj1 == obj2).to be false
        end
      end

      context 'with same class' do
        context 'with same attributes' do
          it 'returns true' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            expect(obj1 == obj2).to be true
          end
        end

        context 'with different attributes' do
          it 'returns false' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'World')
            expect(obj1 == obj2).to be false
          end
        end
      end
    end

    context 'with nested objects' do
      context 'with same attributes' do
        it 'returns true' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          expect(obj1 == obj2).to be true
        end
      end

      context 'with different attributes' do
        it 'returns false' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Different Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'horizontal',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Different Text') # diff
                ]
              )
            )
          )
          expect(obj1 == obj2).to be false
        end
      end
    end
  end

  describe '#hash' do
    context 'with simple objects' do
      context 'with other class (but same origin)' do
        it 'returns different hash values' do
          obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
          obj2 = Line::Bot::V2::MessagingApi::TextMessageV2.new(text: 'Hello')
          expect(obj1.hash).not_to eq(obj2.hash)
        end
      end

      context 'with same class' do
        context 'with same attributes' do
          it 'returns same hash values' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            expect(obj1.hash).to eq(obj2.hash)
          end
        end

        context 'with different attributes' do
          it 'returns different hash values' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'World')
            expect(obj1.hash).not_to eq(obj2.hash)
          end
        end
      end
    end

    context 'with nested objects' do
      context 'with same attributes' do
        it 'returns same hash values' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          expect(obj1.hash).to eq(obj2.hash)
        end
      end

      context 'with different attributes' do
        it 'returns different hash values' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Different Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'horizontal',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Different Text') # diff
                ]
              )
            )
          )
          expect(obj1.hash).not_to eq(obj2.hash)
        end
      end
    end
  end

  describe 'GET /v2/bot/audienceGroup/{audienceGroupId}' do
    let(:client) { Line::Bot::V2::ManageAudience::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:audience_group_id) { 2345678909876 }
    let(:response_body) do
      {
        audienceGroup: {
          audienceGroupId: audience_group_id,
          createRoute: 'AD_MANAGER',
          type: 'APP_EVENT',
          description: 'audienceGroupName_03',
          status: 'READY',
          audienceCount: 8619,
          created: 1608619802,
          permission: 'READ',
          isIfaAudience: false
        },
        jobs: [],
        adaccount: {
          name: 'Ad Account Name'
        }
      }.to_json
    end
    let(:response_code) { 200 }
    it 'path parameter works (integer)' do
      stub_request(:get, "https://api.line.me/v2/bot/audienceGroup/2345678909876")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_audience_data_with_http_info(audience_group_id: audience_group_id)
      expect(status_code).to eq(200)
      expect(body.audience_group.audience_group_id).to eq(audience_group_id)
      expect(body.audience_group.create_route).to eq('AD_MANAGER')
      expect(body.adaccount.name).to eq('Ad Account Name')
    end
  end

  describe 'POST /v2/bot/user/{userId}/richmenu/{richMenuId}' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    it 'path parameter works (string)' do
      user_id = 'U1234567890'
      rich_menu_id = 'richmenu-1234567890-bba-222'

      stub_request(:post, "https://api.line.me/v2/bot/user/U1234567890/richmenu/richmenu-1234567890-bba-222")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: 200, body: '{}', headers: {})

      body, status_code, headers = client.link_rich_menu_id_to_user_with_http_info(user_id: user_id, rich_menu_id: rich_menu_id)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end
  end

  describe 'GET /v2/bot/audienceGroup/list' do
    let(:client) { Line::Bot::V2::ManageAudience::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) do
      { "audienceGroups" => [
          {
            "audienceGroupId" => 1234567890123,
            "createRoute" => "OA_MANAGER",
            "type": "CLICK",
            "description": "audienceGroup Name",
            "status": "IN_PROGRESS",
            "audienceCount": 8619,
            "created": 1611114828,
            "permission": "READ",
            "isIfaAudience": false,
            "requestId": "c10c3d86-f565-...",
            "clickUrl": "https://example.com/"
          },
          {
            "audienceGroupId": 2345678901234,
            "createRoute": "AD_MANAGER",
            "type": "APP_EVENT",
            "description": "audienceGroup Name",
            "status": "READY",
            "audienceCount": 3368,
            "created": 1608619802,
            "permission": "READ",
            "isIfaAudience": false
          }
        ],
        "hasNextPage": false,
        "totalCount": 2,
        "readWriteAudienceGroupTotalCount": 0,
        "size": 40,
        "page": 1}.to_json
    end
    let(:response_code) { 200 }

    it 'query parameter is encoded' do
      stub_request(:get, "https://api.line.me/v2/bot/audienceGroup/list?size=40&page=1&description=audienceGroup%20Name")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_audience_groups_with_http_info(page: 1, size: 40, description: 'audienceGroup Name')

      expect(status_code).to eq(200)
      expect(body.audience_groups.size).to eq(2)
      expect(body.audience_groups[0].description).to eq('audienceGroup Name')
    end
  end
end
