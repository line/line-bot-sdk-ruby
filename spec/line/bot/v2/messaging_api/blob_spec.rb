require 'spec_helper'

describe 'MessagingApi::ApiBlobClient' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

  describe 'Uploading' do
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
end
