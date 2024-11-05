require 'spec_helper'
require 'json'
require_relative 'mock_http_client'

describe Line::Bot::Client do
  def generate_client
    Line::Bot::Client.new do |config|
      config.channel_id = '1234567'
      config.channel_token = 'channelToken'
      config.channel_secret = 'channelSecret'
      config.httpclient = MockHTTPClient.new
    end
  end

  it 'execute create_user_id_audience' do
    payload = {
      description: 'create_user_id_audience 1',
      audiences: [{id: 'u123abc'}]
    }

    response = generate_client.create_user_id_audience(payload)

    expect(response).to eq(
      method: :post,
      url: 'https://api.line.me/v2/bot/audienceGroup/upload',
      payload: payload.to_json
    )
  end

  it 'execute update_user_id_audience' do
    payload = {
      audienceGroupId: 123,
      description: 'audience 1',
      audiences: [{id: 'u123abc'}]
    }

    response = generate_client.update_user_id_audience(payload)

    expect(response).to eq(
      method: :put,
      url: 'https://api.line.me/v2/bot/audienceGroup/upload',
      payload: payload.to_json
    )
  end

  it 'execute create_click_audience' do
    payload = {
      description: 'audience 2',
      requestId: 'a523d8b2-4728-4ac5-ad4f-b176afd43267'
    }

    response = generate_client.create_click_audience(payload)

    expect(response).to eq(
      method: :post,
      url: 'https://api.line.me/v2/bot/audienceGroup/click',
      payload: payload.to_json
    )
  end

  it 'execute create_impression_audience' do
    payload = {
      description: 'audience 3',
      requestId: 'a523d8b2-4728-4ac5-ad4f-b176afd43267'
    }

    response = generate_client.create_impression_audience(payload)

    expect(response).to eq(
      method: :post,
      url: 'https://api.line.me/v2/bot/audienceGroup/imp',
      payload: payload.to_json
    )
  end

  it 'execute rename_audience' do
    response = generate_client.rename_audience(123, 'audience 10')

    expect(response).to eq(
      method: :put,
      url: 'https://api.line.me/v2/bot/audienceGroup/123/updateDescription',
      payload: {description: 'audience 10'}.to_json
    )
  end

  it 'execute delete_audience' do
    response = generate_client.delete_audience(123)

    expect(response).to eq(
      method: :delete,
      url: 'https://api.line.me/v2/bot/audienceGroup/123',
      payload: nil
    )
  end

  it 'execute get_audience' do
    response = generate_client.get_audience(123)

    expect(response).to eq(
      method: :get,
      url: 'https://api.line.me/v2/bot/audienceGroup/123',
      payload: nil
    )
  end

  it 'execute get_audiences' do
    params = {page: 2, status: 'READY'}
    response = generate_client.get_audiences(params)

    expect(response).to eq(
      method: :get,
      url: 'https://api.line.me/v2/bot/audienceGroup/list?page=2&status=READY',
      payload: nil
    )
  end

  it 'execute get_audience_authority_level' do
    response = generate_client.get_audience_authority_level

    expect(response).to eq(
      method: :get,
      url: 'https://api.line.me/v2/bot/audienceGroup/authorityLevel',
      payload: nil
    )
  end

  it 'execute update_audience_authority_level' do
    response = generate_client.update_audience_authority_level('PRIVATE')

    expect(response).to eq(
      method: :put,
      url: 'https://api.line.me/v2/bot/audienceGroup/authorityLevel',
      payload: {authorityLevel: 'PRIVATE'}.to_json
    )
  end
end
