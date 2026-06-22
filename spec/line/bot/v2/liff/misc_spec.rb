require 'spec_helper'

describe 'Liff' do
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
end
