require 'spec_helper'
require 'webmock/rspec'
require 'json'

USER_ID_CONTENT = <<"EOS"
{
    "userIds": [
        "Uxxxxxxxxxxxxxx1",
        "Uxxxxxxxxxxxxxx2",
        "Uxxxxxxxxxxxxxx3"
    ],
    "next": "jxEWCEEP"
}
EOS

NEXT_USER_ID_CONTENT = <<"EOS"
{
    "userIds": [
        "Uxxxxxxxxxxxxxx4",
        "Uxxxxxxxxxxxxxx5",
        "Uxxxxxxxxxxxxxx6"
    ]
}
EOS

LIMITED_USER_ID_CONTENT = <<"EOS"
{
    "userIds": [
        "Uxxxxxxxxxxxxxx1",
        "Uxxxxxxxxxxxxxx2"
    ]
}
EOS

describe Line::Bot::Client do
  def dummy_config
    {
      channel_token: 'access token',
    }
  end

  def generate_client
    client = Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end

    client
  end

  it 'gets follower ids' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/followers/ids'
    stub_request(:get, uri_template).to_return { |request| {body: USER_ID_CONTENT, status: 200} }

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/followers/ids?start={start}'
    stub_request(:get, uri_template).to_return { |request| {body: NEXT_USER_ID_CONTENT, status: 200} }

    client = generate_client

    # first page
    response = client.get_follower_ids

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['userIds']).to eq ["Uxxxxxxxxxxxxxx1", "Uxxxxxxxxxxxxxx2", "Uxxxxxxxxxxxxxx3"]
    expect(result['next']).to eq "jxEWCEEP"

    # second page
    response = client.get_follower_ids(start: result['next'])

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['userIds']).to eq ["Uxxxxxxxxxxxxxx4", "Uxxxxxxxxxxxxxx5", "Uxxxxxxxxxxxxxx6"]
    expect(result['next']).to be nil
  end

  it 'gets limited number of follower ids' do
    # without any other conditions
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/followers/ids?limit={limit}'
    stub_request(:get, uri_template).to_return { |request| {body: LIMITED_USER_ID_CONTENT, status: 200} }

    # with other conditions
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/followers/ids?limit={limit}&start={start}'
    stub_request(:get, uri_template).to_return { |request| {body: LIMITED_USER_ID_CONTENT, status: 200} }

    client = generate_client

    # without any other conditions
    response = client.get_follower_ids(limit: 2)
    result = JSON.parse(response.body)
    expect(response).to be_a(Net::HTTPOK)
    expect(result['userIds']).to eq ["Uxxxxxxxxxxxxxx1", "Uxxxxxxxxxxxxxx2"]

    # with other conditions
    response = client.get_follower_ids(start: 'foo', limit: 2)
    result = JSON.parse(response.body)
    expect(response).to be_a(Net::HTTPOK)
    expect(result['userIds']).to eq ["Uxxxxxxxxxxxxxx1", "Uxxxxxxxxxxxxxx2"]
  end

  it 'gets follower ids using deprecated_continuation_token argument' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/followers/ids'
    stub_request(:get, uri_template).to_return { |request| {body: USER_ID_CONTENT, status: 200} }

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/followers/ids?start={start}'
    stub_request(:get, uri_template).to_return { |request| {body: NEXT_USER_ID_CONTENT, status: 200} }

    client = generate_client

    # first page
    response = client.get_follower_ids

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['userIds']).to eq ["Uxxxxxxxxxxxxxx1", "Uxxxxxxxxxxxxxx2", "Uxxxxxxxxxxxxxx3"]
    expect(result['next']).to eq "jxEWCEEP"

    # second page
    response = client.get_follower_ids(result['next'])

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['userIds']).to eq ["Uxxxxxxxxxxxxxx4", "Uxxxxxxxxxxxxxx5", "Uxxxxxxxxxxxxxx6"]
    expect(result['next']).to be nil
  end
end
