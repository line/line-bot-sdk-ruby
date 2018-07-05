require 'spec_helper'
require 'webmock/rspec'
require 'json'

WebMock.allow_net_connect!

describe Line::Bot::Client do
  it 'pushes the imagemap message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/push'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_id = 'user_id'
    message = {
      type: 'imagemap',
      baseUrl: 'https://example.com/image',
      altText: 'this is an imagemap message',
      baseSize: {
        width: 1040,
        height: 1040,
      },
      actions: [
        {
          type: 'uri',
          linkUri: 'https://github.com/line/line-bot-sdk-ruby',
          area: {
            x: 0,
            y: 0,
            width: 520,
            height: 1040,
          },
        },
        {
          type: 'message',
          text: 'Hello',
          area: {
            x: 520,
            y: 0,
            width: 520,
            height: 1040,
          },
        },
      ],
    }
    response = client.push_message(user_id, message)

    expected = {
      to: user_id,
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'replies the imagemap message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/reply'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    reply_token = 'reply_token'
    message = {
      type: 'imagemap',
      baseUrl: 'https://example.com/image',
      altText: 'this is an imagemap message',
      baseSize: {
        width: 1040,
        height: 1040,
      },
      actions: [
        {
          type: 'uri',
          linkUri: 'https://github.com/line/line-bot-sdk-ruby',
          area: {
            x: 0,
            y: 0,
            width: 520,
            height: 1040,
          },
        },
        {
          type: 'message',
          text: 'Hello',
          area: {
            x: 520,
            y: 0,
            width: 520,
            height: 1040,
          },
        },
      ],
    }
    response = client.reply_message(reply_token, message)

    expected = {
      replyToken: reply_token,
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'multicasts the imagemap message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/multicast'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_ids = ['user1', 'user2']
    message = {
      type: 'imagemap',
      baseUrl: 'https://example.com/image',
      altText: 'this is an imagemap message',
      baseSize: {
        width: 1040,
        height: 1040,
      },
      actions: [
        {
          type: 'uri',
          linkUri: 'https://github.com/line/line-bot-sdk-ruby',
          area: {
            x: 0,
            y: 0,
            width: 520,
            height: 1040,
          },
        },
        {
          type: 'message',
          text: 'Hello',
          area: {
            x: 520,
            y: 0,
            width: 520,
            height: 1040,
          },
        },
      ],
    }
    response = client.multicast(user_ids, message)

    expected = {
      to: user_ids,
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end
end
