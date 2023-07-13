require 'spec_helper'
require 'webmock/rspec'

class TestClient
  def get(url, header = {})
    {
      url: url,
      header: header
    }
  end

  def post(url, payload, header = {})
    {
      url: url,
      payload: payload,
      header: header
    }
  end
end

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

  before do
    stub_request(:post, Line::Bot::API::DEFAULT_ENDPOINT).to_return { |request| {body: request.body, status: 200} }
  end

  it 'default endpoint' do
    client = Line::Bot::Client.new
    expect(client.endpoint).to eq Line::Bot::API::DEFAULT_ENDPOINT
    expect(client.blob_endpoint).to eq Line::Bot::API::DEFAULT_BLOB_ENDPOINT
  end

  it 'rewrite endpoint' do
    client = Line::Bot::Client.new do |config|
      config.endpoint = 'https://example.com/api/v1'
      config.blob_endpoint = 'https://example.com/api-data/v1'
    end
    expect(client.endpoint).to eq 'https://example.com/api/v1'
    expect(client.blob_endpoint).to eq 'https://example.com/api-data/v1'
  end

  it 'rewrite endpoint and backward compatible' do
    client = Line::Bot::Client.new do |config|
      config.endpoint = 'https://example.com/api/v1'
    end
    expect(client.endpoint).to eq 'https://example.com/api/v1'
    expect(client.blob_endpoint).to eq 'https://example.com/api/v1' # rewrited
  end

  it 'checks credentials on creating a client' do
    channel_token = dummy_config[:channel_token]
    client = Line::Bot::Client.new do |config|
      config.channel_token = channel_token
    end

    credentials = client.credentials
    expect(credentials['Authorization']).to eq "Bearer #{channel_token}"
  end

  it 'checks credentials on creating a client with arguments' do
    channel_token = dummy_config[:channel_token]
    client = Line::Bot::Client.new(
      channel_token: channel_token
    )

    credentials = client.credentials
    expect(credentials['Authorization']).to eq "Bearer #{channel_token}"
  end

  it 'assorts request parameters when httpclient is replaced' do
    client = Line::Bot::Client.new do |config|
      config.httpclient = TestClient.new
      config.channel_token = dummy_config[:channel_token]
    end

    expect(client.httpclient).to be_a(TestClient)

    identifier = "12345"

    # get
    result = client.get_message_content(identifier)

    expect(result[:url]).to eq Line::Bot::API::DEFAULT_BLOB_ENDPOINT + "/bot/message/#{identifier}/content"

    header = result[:header]
    expect(header['Authorization']).to eq "Bearer #{dummy_config[:channel_token]}"
    expect(header['User-Agent']).to eq "LINE-BotSDK-Ruby/" + LINE::Client::VERSION

    expect(result[:payload]).to be nil

    # post
    user_id = "user1"
    message = {
      type: "text",
      text: "Hello, world"
    }

    result = client.push_message(user_id, message)

    expect(result[:url]).to eq Line::Bot::API::DEFAULT_ENDPOINT + "/bot/message/push"

    header = result[:header]
    expect(header['Authorization']).to eq "Bearer #{dummy_config[:channel_token]}"
    expect(header['User-Agent']).to eq "LINE-BotSDK-Ruby/" + LINE::Client::VERSION
    expect(header['Content-Type']).to eq "application/json; charset=UTF-8"

    body = JSON.parse(result[:payload], symbolize_names: true)

    expect(body[:to]).to eq user_id

    messages = body[:messages]
    expect(messages[0]).to eq message
  end

  it 'set X-Line-Retry-Key' do
    client = Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end

    available_endpoints = [
      '/bot/message/push',
      '/bot/message/multicast',
      '/bot/message/narrowcast',
      '/bot/message/broadcast'
    ]

    available_endpoints.each do |available_endpoint|
      uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + available_endpoint
      stub_request(:post, uri_template).with do |request|
        expect(request.headers['X-Line-Retry-Key']).to eq '123e4567-e89b-12d3-a456-426614174000'
      end.to_return(body: '{}', status: 200)
    end

    user_id = "user1"
    message = {
      type: "text",
      text: "Hello, world"
    }

    client.push_message(user_id, message, headers: {'X-Line-Retry-Key' => '123e4567-e89b-12d3-a456-426614174000'})
    client.multicast(user_id, message, headers: {'X-Line-Retry-Key' => '123e4567-e89b-12d3-a456-426614174000'})
    client.narrowcast(message, headers: {'X-Line-Retry-Key' => '123e4567-e89b-12d3-a456-426614174000'})
    client.broadcast(message, headers: {'X-Line-Retry-Key' => '123e4567-e89b-12d3-a456-426614174000'})
  end
end
