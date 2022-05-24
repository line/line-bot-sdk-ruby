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

ISSUE_CHANNEL_ACCESS_TOKEN_JWT_CONTENT = <<"EOS"
{
    "access_token": "eyJhbGciOiJIUzxxxxxx",
    "token_type": "Bearer",
    "expires_in": 2592000,
    "key_id": "sDTOzw5wIfxxxxPEzcmeQA"
}
EOS

GET_CHANNEL_ACCESS_TOKEN_KEY_IDS_JWT_CONTENT = <<"EOS"
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

VERIFY_ID_TOKEN_CONTENT = <<"EOS"
{
    "iss": "https://access.line.me",
    "sub": "U1234567890abcdef1234567890abcdef",
    "aud": "1234567890",
    "exp": 1504169092,
    "iat": 1504263657,
    "nonce": "0987654asdf",
    "amr": ["pwd"],
    "name": "Taro Line",
    "picture": "https://sample_line.me/aBcdefg123456",
    "email": "taro.line@example.com"
}
EOS

VERIFY_ACCESS_TOKEN_CONTENT = <<"EOS"
{
    "scope": "profile",
    "client_id": "1440057261",
    "expires_in": 2591659
}
EOS

PROFILE_BY_ACCESS_TOKEN_CONTENT = <<"EOS"
{
    "userId": "U4af4980629...",
    "displayName": "Brown",
    "pictureUrl": "https://profile.line-scdn.net/abcdefghijklmn",
    "statusMessage": "Hello, LINE!"
}
EOS

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
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + '/oauth2/v2.1/token'
    stub_request(:post, uri_template).to_return { |request| {body: ISSUE_CHANNEL_ACCESS_TOKEN_JWT_CONTENT, status: 200} }

    client = generate_client
    response = client.issue_channel_access_token_jwt('jwt_string')

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['access_token']).to eq 'eyJhbGciOiJIUzxxxxxx'
    expect(result['expires_in']).to eq 2592000
    expect(result['token_type']).to eq 'Bearer'
    expect(result['key_id']).to eq 'sDTOzw5wIfxxxxPEzcmeQA'
  end

  it 'revokes the oauth access token v2.1' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + '/oauth2/v2.1/revoke'
    stub_request(:post, uri_template).to_return { |request| {body: '', status: 200} }

    client = generate_client

    response = client.revoke_channel_access_token_jwt('sDTOzw5wIfxxxxPEzcmeQA')

    expect(response).to be_a(Net::HTTPOK)
  end

  it 'get all valid channel access token key ids v2.1' do
    client_assertion = 'jwt_string'
    client_assertion_type = 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer'

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT +
                                             "/oauth2/v2.1/tokens/kid?client_assertion=#{client_assertion}&client_assertion_type=#{client_assertion_type}"
    stub_request(:any, uri_template).to_return { |request| {body: GET_CHANNEL_ACCESS_TOKEN_KEY_IDS_JWT_CONTENT, status: 200} }

    client = generate_client

    response = client.get_channel_access_token_key_ids_jwt('jwt_string')

    expect(response).to be_a(Net::HTTPOK)
  end

  it 'verifies ID token' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + '/oauth2/v2.1/verify'
    stub_request(:post, uri_template)
      .with(body: { client_id: 'channel id', id_token: 'dummy_id_token', nonce: 'dummy_nonce'})
      .to_return { |request| {body: VERIFY_ID_TOKEN_CONTENT, status: 200} }

    client = generate_client

    response = client.verify_id_token('dummy_id_token', nonce: 'dummy_nonce')

    expect(response).to be_a(Net::HTTPOK).and(have_attributes(body: VERIFY_ID_TOKEN_CONTENT))
  end

  it 'verifies access token' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + '/oauth2/v2.1/verify?access_token=dummy_access_token'
    stub_request(:get, uri_template).to_return { |request| {body: VERIFY_ACCESS_TOKEN_CONTENT, status: 200} }

    client = generate_client

    response = client.verify_access_token('dummy_access_token')

    expect(response).to be_a(Net::HTTPOK).and(have_attributes(body: VERIFY_ACCESS_TOKEN_CONTENT))
  end

  it 'gets profile by access token' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + '/v2/profile'
    stub_request(:get, uri_template)
      .with(headers: { 'Authorization' =>  'Bearer dummy_access_token'})
      .to_return { |request| {body: PROFILE_BY_ACCESS_TOKEN_CONTENT, status: 200} }

    client = generate_client

    response = client.get_profile_by_access_token('dummy_access_token')

    expect(response).to be_a(Net::HTTPOK).and(have_attributes(body: PROFILE_BY_ACCESS_TOKEN_CONTENT))
  end
end
