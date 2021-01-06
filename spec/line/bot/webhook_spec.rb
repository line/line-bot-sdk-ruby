require 'spec_helper'
require 'webmock/rspec'
require 'json'

WEBHOOK_ENDPOINT_CONTENT = <<"EOS"
{
  "endpoint": "https://example.com/test",
  "active": true
}
EOS

describe Line::Bot::Client do
  let(:client) do
    dummy_config = {
      channel_token: 'access token',
    }
    Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  end

  it 'get webhook endpoint' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/channel/webhook/endpoint'
    stub_request(:get, uri_template).to_return(body: WEBHOOK_ENDPOINT_CONTENT, status: 200)

    response = client.get_webhook_endpoint

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq(
      endpoint: 'https://example.com/test',
      active: true
    )
  end
end
