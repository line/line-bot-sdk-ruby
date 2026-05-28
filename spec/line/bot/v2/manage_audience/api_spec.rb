require 'spec_helper'

describe 'ManageAudience::ApiClient path parameters' do
  let(:client) { Line::Bot::V2::ManageAudience::ApiClient.new(channel_access_token: 'test_channel_access_token') }

  describe 'DELETE /v2/bot/audienceGroup/{audienceGroupId} (delete_audience_group)' do
    it 'substitutes a numeric audience_group_id into the path' do
      stub_request(:delete, 'https://api.line.me/v2/bot/audienceGroup/0')
        .to_return(status: 200, body: '')

      _body, status_code, _headers = client.delete_audience_group_with_http_info(audience_group_id: 0)

      expect(status_code).to eq(200)
    end

    it 'rejects "." or ".." passed as audience_group_id' do
      expect do
        client.delete_audience_group_with_http_info(audience_group_id: '..')
      end.to raise_error(ArgumentError, /path traversal/)

      expect do
        client.delete_audience_group_with_http_info(audience_group_id: '.')
      end.to raise_error(ArgumentError, /path traversal/)
    end

    it 'percent-encodes a traversal-looking value so the slash stays inside the segment' do
      # Without the fix the request would hit
      # /v2/bot/audienceGroup/../message/quota which normalizes to
      # /v2/bot/message/quota. With encoding the slash becomes %2F so the
      # final URL still has a single segment after audienceGroup/.
      stub_request(:delete, 'https://api.line.me/v2/bot/audienceGroup/..%2Fmessage%2Fquota')
        .to_return(status: 200, body: '')

      _body, status_code, _headers = client.delete_audience_group_with_http_info(audience_group_id: '../message/quota')

      expect(status_code).to eq(200)
    end
  end

  describe 'GET /v2/bot/audienceGroup/shared/{audienceGroupId} (get_shared_audience_data)' do
    let(:response_body) do
      { 'audienceGroup' => { 'audienceGroupId' => 12345 } }.to_json
    end

    it 'substitutes a numeric audience_group_id into the path' do
      stub_request(:get, 'https://api.line.me/v2/bot/audienceGroup/shared/12345')
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, _headers = client.get_shared_audience_data_with_http_info(audience_group_id: 12345)

      expect(status_code).to eq(200)
      expect(body.audience_group.audience_group_id).to eq(12345)
    end
  end

  describe 'PUT /v2/bot/audienceGroup/{audienceGroupId}/updateDescription' do
    let(:request_body) do
      Line::Bot::V2::ManageAudience::UpdateAudienceGroupDescriptionRequest.new(description: 'renamed-audience')
    end

    it 'substitutes a numeric audience_group_id into the path' do
      stub_request(:put, 'https://api.line.me/v2/bot/audienceGroup/999/updateDescription')
        .with(body: { 'description' => 'renamed-audience' })
        .to_return(status: 200, body: '')

      _body, status_code, _headers = client.update_audience_group_description_with_http_info(
        audience_group_id: 999,
        update_audience_group_description_request: request_body
      )

      expect(status_code).to eq(200)
    end
  end
end
