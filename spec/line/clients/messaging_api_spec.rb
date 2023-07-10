require 'spec_helper'
require 'webmock/rspec'

describe LINE::Client::MessagingApi do
  it 'gets webhook endpoint information' do
    stub_request(:get, 'https://api.line.me/v2/bot/channel/webhook/endpoint')
      .with(
        headers: {
          'Authorization' => 'Bearer YOUR_BEARER_TOKEN',
        }
      )
      .to_return(
        status: 200,
        body: JSON.generate(
          'endpoint': 'https://example.com/test',
          'active': true
        ),
        headers: {}
      )

    LINE::Client::MessagingApi.configure do |config|
      config.access_token = 'YOUR_BEARER_TOKEN'
    end

    api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
    result = api_instance.get_webhook_endpoint
    expect(result.endpoint).to eq 'https://example.com/test'
    expect(result.active).to be_truthy
  end
end
