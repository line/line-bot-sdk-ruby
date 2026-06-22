require 'spec_helper'

describe 'ManageAudience' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

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
