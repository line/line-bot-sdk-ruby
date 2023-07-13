require 'spec_helper'
require 'webmock/rspec'
require 'json'

LIFF_APP_CONTENT = <<LIFF
{
  "liffId": "1234567-abcdefgh",
  "view": {
    "type": "full",
    "url": "https://example.com/myservice"
  },
  "description": "Happy New York",
  "permanentLinkPattern": "concat"
}
LIFF
LIFF_APP_LIST_CONTENT = <<LIFF
{
    "apps": [
    #{LIFF_APP_CONTENT}
    ]
}
LIFF

LIFF_ENDPOINT = 'https://api.line.me'

describe Line::Bot::Client do
  let(:client) do
    dummy_config = {
      channel_token: 'access token',
    }
    Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  end

  it 'gets a list of liff apps' do
    uri_template = Addressable::Template.new LIFF_ENDPOINT + '/liff/v1/apps'
    stub_request(:get, uri_template).to_return(body: LIFF_APP_LIST_CONTENT, status: 200)

    response = client.get_liff_apps
    expect(WebMock).to have_requested(:get, LIFF_ENDPOINT + '/liff/v1/apps')
    expect(response.body).to eq LIFF_APP_LIST_CONTENT
  end

  it 'updates a liff app' do
    uri_template = Addressable::Template.new LIFF_ENDPOINT + '/liff/v1/apps/1234567-abcdefgh'
    stub_request(:put, uri_template).to_return(body: LIFF_APP_CONTENT, status: 200)

    response = client.update_liff_app('1234567-abcdefgh', JSON.parse(LIFF_APP_CONTENT))
    expect(WebMock).to have_requested(:put, LIFF_ENDPOINT + '/liff/v1/apps/1234567-abcdefgh')
      .with(body: JSON.parse(LIFF_APP_CONTENT).to_json)
    expect(response.body).to eq LIFF_APP_CONTENT
  end

  it 'creates a liff app' do
    uri_template = Addressable::Template.new LIFF_ENDPOINT + '/liff/v1/apps'
    stub_request(:post, uri_template).to_return(body: LIFF_APP_CONTENT, status: 200)

    client.create_liff_app(JSON.parse(LIFF_APP_CONTENT))
    expect(WebMock).to have_requested(:post, LIFF_ENDPOINT + '/liff/v1/apps')
      .with(body: JSON.parse(LIFF_APP_CONTENT).to_json)
  end

  it 'deletes a liff app' do
    uri_template = Addressable::Template.new LIFF_ENDPOINT + '/liff/v1/apps/1234567-abcdefgh'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    client.delete_liff_app('1234567-abcdefgh')
    expect(WebMock).to have_requested(:delete, LIFF_ENDPOINT + '/liff/v1/apps/1234567-abcdefgh')
  end
end
