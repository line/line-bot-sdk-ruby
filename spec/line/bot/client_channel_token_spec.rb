require 'spec_helper'
require 'webmock/rspec'
require 'json'

OAUTH_CHANNEL_TOKEN_ISSUE_CONTENT = <<"EOS"
{
    "access_token": "W1TeHCgfH2Liwaxxxxx1",
    "expires_in": 2592000,
    "token_type": "Bearer"
}
EOS

ISSUE_CHANNEL_ACCESS_TOKEN_21_CONTENT = <<"EOS"
{
    "access_token": "eyJhbGciOiJIUzxxxxxx",
    "token_type": "Bearer",
    "expires_in": 2592000,
    "key_id": "sDTOzw5wIfxxxxPEzcmeQA"
}
EOS

GET_CHANNEL_ACCESS_TOKEN_KEY_IDS_21_CONTENT = <<"EOS"
{
    "key_ids": [
        "U_gdnFYKTWRxxxxDVZexGg",
        "sDTOzw5wIfWxxxxzcmeQA",
        "73hDyp3PxGfxxxxD6U5qYA",
        "FHGanaP79smDxxxxyPrVw",
        "CguB-0kxxxxdSM3A5Q_UtQ",
        "G82YP96jhHwyKSxxxx7IFA"
    ]
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
    stub_request(:post, uri_template).to_return { |request| {body: OAUTH_CHANNEL_TOKEN_ISSUE_CONTENT, status: 200} }

    client = generate_client
    response = client.issue_channel_token

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

    response = client.revoke_channel_token('W1TeHCgfH2Liwaxxxxx1')

    expect(response).to be_a(Net::HTTPOK)
  end

  it 'issues an oauth access token v2.1' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/oauth2/v2.1/token'
    stub_request(:post, uri_template).to_return { |request| {body: ISSUE_CHANNEL_ACCESS_TOKEN_21_CONTENT, status: 200} }

    client = generate_client
    response = client.issue_channel_access_token_21('jwt_string')

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['access_token']).to eq 'eyJhbGciOiJIUzxxxxxx'
    expect(result['expires_in']).to eq 2592000
    expect(result['token_type']).to eq 'Bearer'
    expect(result['key_id']).to eq 'sDTOzw5wIfxxxxPEzcmeQA'
  end

  it 'revokes the oauth access token v2.1' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/oauth2/v2.1/revoke'
    stub_request(:post, uri_template).to_return { |request| {body: '', status: 200} }

    client = generate_client

    response = client.revoke_channel_access_token_21('sDTOzw5wIfxxxxPEzcmeQA'):

    expect(response).to be_a(Net::HTTPOK)
  end

  it 'get all valid channel access token key ids v2.1' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/oauth2/v2.1/tokens/kid'
    stub_request(:post, uri_template).to_return { |request| {body: GET_CHANNEL_ACCESS_TOKEN_KEY_IDS_21_CONTENT, status: 200} }

    client = generate_client

    response = client.get_channel_access_token_key_ids_21('jwt_string')

    expect(response).to be_a(Net::HTTPOK)
  end
end
