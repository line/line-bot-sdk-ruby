require 'spec_helper'
require 'webmock/rspec'
require 'json'

describe Line::Bot::Client do
  it 'pushes the text message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/push'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_id = 'user_id'
    message = {
      type: 'text',
      text: 'Hello, world'
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

  it 'push the text message with additional payload' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/push'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_id = 'user_id'
    message = {
      type: 'text',
      text: 'Hello, world'
    }
    response = client.push_message(user_id, message, payload: {customAggregationUnits: ['test']})

    expected = {
      customAggregationUnits: ['test'],
      to: user_id,
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'replies the text message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/reply'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    reply_token = 'reply_token'
    message = {
      type: 'text',
      text: 'Hello, world'
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

  it 'multicasts the text message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/multicast'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_ids = ['user1', 'user2']
    message = {
      type: 'text',
      text: 'Hello, world'
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

  it 'multicasts the text message with additional payload' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/multicast'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_ids = ['user1', 'user2']
    message = {
      type: 'text',
      text: 'Hello, world'
    }
    response = client.multicast(user_ids, message, payload: {customAggregationUnits: ['test']})

    expected = {
      customAggregationUnits: ['test'],
      to: user_ids,
      messages: [
        message
      ],
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'broadcasts the text message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/broadcast'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    message = {
      type: 'text',
      text: 'Hello, world'
    }
    response = client.broadcast(message)

    expected = {
      messages: [
        message
      ]
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'narrowcast the text message without any conditions' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/narrowcast'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    message = {
      type: 'text',
      text: 'Hello, world'
    }
    response = client.narrowcast(message)

    expected = {
      messages: [message],
      recipient: nil,
      filter: nil,
      limit: nil
    }.to_json
    expect(response.body).to eq(expected)
  end

  it 'narrowcast the text message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/narrowcast'
    stub_request(:post, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    message = {
      type: 'text',
      text: 'Hello, world'
    }
    recipient = {
      type: 'audience',
      audienceGroupId: 5614991017776
    }
    filter = {
      demographic: {
        type: 'appType',
        oneOf: [
          'android'
        ]
      }
    }
    limit = {
      max: 300
    }
    response = client.narrowcast(message, recipient: recipient, filter: filter, limit: limit)

    expected = {
      messages: [message],
      recipient: recipient,
      filter: filter,
      limit: limit
    }.to_json
    expect(response.body).to eq(expected)
  end
end
