require 'spec_helper'
require 'webmock/rspec'

class TestClient < Line::Bot::HttpClient
  def get(url, query: {}, header: {})
    {
      url: url,
      query: query,
      header: header
    }
  end

  def post(url, payload, query: {}, header: {})
    {
      url: url,
      query: query,
      payload: payload,
      header: header
    }
  end
end

WebMock.allow_net_connect!

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

  it 'checks headers on creating a client' do
    channel_token = dummy_config[:channel_token]
    expected_headers = {
      'Authorization' => "Bearer #{channel_token}",
      'User-Agent' => "LINE-BotSDK-Ruby/#{Line::Bot::API::VERSION}",
      'Content-Type' => 'application/json; charset=UTF-8'
    }

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/multicast'
    stub_request(:post, uri_template)
      .with(headers: expected_headers)
      .to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = channel_token
    end
    result = client.multicast('user', {})
    expect(result.code).to eq '200'
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

    expect(result[:url]).to eq Line::Bot::API::DEFAULT_ENDPOINT + "/bot/message/#{identifier}/content"

    expect(result[:payload]).to be nil

    # post
    user_id = "user1"
    message = {
      type: "text",
      text: "Hello, world"
    }

    result = client.push_message(user_id, message)

    expect(result[:url]).to eq Line::Bot::API::DEFAULT_ENDPOINT + "/bot/message/push"

    body = JSON.parse(result[:payload], symbolize_names: true)

    expect(body[:to]).to eq user_id

    messages = body[:messages]
    expect(messages[0]).to eq message
  end
end
