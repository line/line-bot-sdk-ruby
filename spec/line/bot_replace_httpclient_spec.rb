require 'spec_helper'
require 'webmock/rspec'
require 'rest-client'
require 'httpclient'
require 'json'

class TestRestClient

  def get(url, header = {})
    RestClient.get(url, header: header)
  end

  def post(url, payload, header = {})
    RestClient.post(url, payload, header: header)
  end

end

class TestHTTPClient < HTTPClient

  def get(url, header = {})
    get_content(url, nil, header)
  end

  def post(url, payload, header = {})
    post_content(url, payload, header)
  end

end

describe Line::Bot::HTTPClient do

  def dummy_config
    {
      channel_id: 1441301333,
      channel_secret: 'testsecret',
      channel_mid: 'u0a556cffd4da0dd89c94fb36e36e1cdc',
    }
  end

  it 'creates a client and uses library `rest-client` as httpclient' do
    stub_request(:post, 'https://trialbot-api.line.me/v1/events').to_return { |request| { headers: request.headers, body: request.body, status: 200} }

    httpclient = TestRestClient.new
    client = Line::Bot::Client.new do |config|
      config.httpclient = httpclient
      config.channel_id = dummy_config[:channel_id]
      config.channel_secret = dummy_config[:channel_secret]
      config.channel_mid = dummy_config[:channel_mid]
    end

    to_mid = "1"
    text   = "text"

    expect(client.httpclient).to be_a(TestRestClient)
    result = client.send_text(to_mid: to_mid, text: text)

    header = eval(result.headers[:header])
    expect(header['X-Line-ChannelID'].to_i).to eq dummy_config[:channel_id]
    expect(header['X-Line-ChannelSecret']).to eq dummy_config[:channel_secret]
    expect(header['X-Line-Trusted-User-With-ACL']).to eq dummy_config[:channel_mid]

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]
    expect(body['eventType'].to_i).to eq Line::Bot::EventType::MESSAGE
    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::TEXT
    expect(body['content']['toType']).to eq Line::Bot::Message::RecipientType::USER
    expect(body['content']['text']).to eq text
  end

  it 'creates a client and uses library `httpclient` as httpclient' do
    stub_request(:post, 'https://trialbot-api.line.me/v1/events').to_return { |request| { body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.httpclient = TestHTTPClient.new
      config.channel_id = dummy_config[:channel_id]
      config.channel_secret = dummy_config[:channel_secret]
      config.channel_mid = dummy_config[:channel_mid]
    end

    to_mid = "1"
    text   = "text"

    expect(client.httpclient).to be_a(TestHTTPClient)
    result = client.send_text(to_mid: to_mid, text: text)

    body = JSON.parse(result)

    expect(body['to']).to eq [to_mid]
    expect(body['eventType'].to_i).to eq Line::Bot::EventType::MESSAGE
    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::TEXT
    expect(body['content']['toType']).to eq Line::Bot::Message::RecipientType::USER
    expect(body['content']['text']).to eq text
  end
end
