require 'spec_helper'
require 'webmock/rspec'
require 'json'

OAUTH_ACCESS_TOKEN_ISSUE_CONTENT = <<"EOS"
{
    "access_token": "W1TeHCgfH2Liwaxxxxx1",
    "expires_in": 2592000,
    "token_type": "Bearer"
}
EOS

WebMock.allow_net_connect!

describe Line::Bot::Client do
  def dummy_config
    {
      channel_id: 'channel id',
      channel_secret: 'channel secret',
    }
  end

  def generate_client
    Line::Bot::Client.new do |config|
      config.channel_id     = dummy_config[:channel_id]
      config.channel_secret = dummy_config[:channel_secret]
    end
  end

  it 'issues an oauth access token' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/oauth/accessToken'
    stub_request(:post, uri_template).to_return { |request| {body: OAUTH_ACCESS_TOKEN_ISSUE_CONTENT, status: 200} }

    client = generate_client
    grant_type = 'client_credentials'

    response = client.issue_access_token(grant_type)

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['access_token']).to eq 'W1TeHCgfH2Liwaxxxxx1'
    expect(result['expires_in']).to eq 2592000
    expect(result['token_type']).to eq 'Bearer'
  end

  it 'revokes the oauth access token' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/oauth/revoke'
    stub_request(:post, uri_template).to_return { |request| {body: '', status: 200} }

    client = generate_client

    response = client.revoke_access_token('W1TeHCgfH2Liwaxxxxx1')

    expect(response).to be_a(Net::HTTPOK)
  end
end
