require 'spec_helper'
require 'webmock/rspec'
require 'json'

WebMock.allow_net_connect!

describe Line::Bot::Client do
  it 'pushes the image carousel message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/push'
    stub_request(:post, uri_template).to_return { |request| { body: request.body, status: 200 } }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_id = 'user_id'
    message = {
      type: 'template',
      altText: 'this is a image carousel template',
      template: {
        type: 'image_carousel',
        columns: [
          {
            imageUrl: 'https://example.com/bot/images/item1.jpg',
            action: {
              type: 'postback',
              label: 'Buy',
              data: 'action=buy&itemid=111'
            }
          },
          {
            imageUrl: 'https://example.com/bot/images/item2.jpg',
            action: {
              type: 'message',
              label: 'Yes',
              text: 'yes'
            }
          },
          {
            imageUrl: 'https://example.com/bot/images/item3.jpg',
            action: {
              type: 'uri',
              label: 'View detail',
              uri: 'http://example.com/page/222'
            }
          }
        ]
      }
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

  it 'replies the image carousel message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/reply'
    stub_request(:post, uri_template).to_return { |request| { body: request.body, status: 200 } }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    reply_token = 'reply_token'
    message = {
      type: 'template',
      altText: 'this is a image carousel template',
      template: {
        type: 'image_carousel',
        columns: [
          {
            imageUrl: 'https://example.com/bot/images/item1.jpg',
            action: {
              type: 'postback',
              label: 'Buy',
              data: 'action=buy&itemid=111'
            }
          },
          {
            imageUrl: 'https://example.com/bot/images/item2.jpg',
            action: {
              type: 'message',
              label: 'Yes',
              text: 'yes'
            }
          },
          {
            imageUrl: 'https://example.com/bot/images/item3.jpg',
            action: {
              type: 'uri',
              label: 'View detail',
              uri: 'http://example.com/page/222'
            }
          }
        ]
      }
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

  it 'multicasts the image carousel message' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/multicast'
    stub_request(:post, uri_template).to_return { |request| { body: request.body, status: 200 } }

    client = Line::Bot::Client.new do |config|
      config.channel_token = 'channel_token'
    end

    user_ids = %w[user1 user2]
    message = {
      type: 'template',
      altText: 'this is a image carousel template',
      template: {
        type: 'image_carousel',
        columns: [
          {
            imageUrl: 'https://example.com/bot/images/item1.jpg',
            action: {
              type: 'postback',
              label: 'Buy',
              data: 'action=buy&itemid=111'
            }
          },
          {
            imageUrl: 'https://example.com/bot/images/item2.jpg',
            action: {
              type: 'message',
              label: 'Yes',
              text: 'yes'
            }
          },
          {
            imageUrl: 'https://example.com/bot/images/item3.jpg',
            action: {
              type: 'uri',
              label: 'View detail',
              uri: 'http://example.com/page/222'
            }
          }
        ]
      }
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
