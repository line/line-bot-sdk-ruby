require 'spec_helper'
require 'webmock/rspec'
require 'json'

MESSAGE_OBJECTS = {
  messages: [
    {
      type: 'text',
      text: 'Hello, world'
    }
  ]
}

RESPONSE_BODY = <<"EOS"
{}
EOS

describe Line::Bot::Client do
  def dummy_config
    {
      channel_token: 'access token',
    }
  end

  def client
    Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  end

  it 'validates message objects of a reply message' do
    uri_template = Addressable::Template.new(Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/validate/reply')
    stub_request(:post, uri_template).with(body: MESSAGE_OBJECTS).to_return { |request| { body: RESPONSE_BODY, status: 200 } }

    messages = [
      {
        type: 'text',
        text: 'Hello, world'
      }
    ]

    response = client.validate_reply_message_objects(messages)
    expect(response).to be_a(Net::HTTPOK)
    expect(JSON.parse(response.body)).to eq({})
  end

  it 'validates message objects of a push message' do
    uri_template = Addressable::Template.new(Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/validate/push')
    stub_request(:post, uri_template).with(body: MESSAGE_OBJECTS).to_return { |request| { body: RESPONSE_BODY, status: 200 } }

    messages = [
      {
        type: 'text',
        text: 'Hello, world'
      }
    ]

    response = client.validate_push_message_objects(messages)
    expect(response).to be_a(Net::HTTPOK)
    expect(JSON.parse(response.body)).to eq({})
  end

  it 'validates message objects of a multicast message' do
    uri_template = Addressable::Template.new(Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/validate/multicast')
    stub_request(:post, uri_template).with(body: MESSAGE_OBJECTS).to_return { |request| { body: RESPONSE_BODY, status: 200 } }

    messages = [
      {
        type: 'text',
        text: 'Hello, world'
      }
    ]

    response = client.validate_multicast_message_objects(messages)
    expect(response).to be_a(Net::HTTPOK)
    expect(JSON.parse(response.body)).to eq({})
  end

  it 'validates message objects of a narrowcast message' do
    uri_template = Addressable::Template.new(Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/validate/narrowcast')
    stub_request(:post, uri_template).with(body: MESSAGE_OBJECTS).to_return { |request| { body: RESPONSE_BODY, status: 200 } }

    messages = [
      {
        type: 'text',
        text: 'Hello, world'
      }
    ]

    response = client.validate_narrowcast_message_objects(messages)
    expect(response).to be_a(Net::HTTPOK)
    expect(JSON.parse(response.body)).to eq({})
  end

  it 'validates message objects of a broadcast message' do
    uri_template = Addressable::Template.new(Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/validate/broadcast')
    stub_request(:post, uri_template).with(body: MESSAGE_OBJECTS).to_return { |request| { body: RESPONSE_BODY, status: 200 } }

    messages = [
      {
        type: 'text',
        text: 'Hello, world'
      }
    ]

    response = client.validate_broadcast_message_objects(messages)
    expect(response).to be_a(Net::HTTPOK)
    expect(JSON.parse(response.body)).to eq({})
  end
end
