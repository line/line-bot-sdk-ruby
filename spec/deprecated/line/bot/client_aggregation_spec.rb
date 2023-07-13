require 'spec_helper'
require 'webmock/rspec'
require 'json'

STATISTICS_CONTENT = <<~"EOS"
{
  "overview": {
    "uniqueImpression": 40,
    "uniqueClick": 30,
    "uniqueMediaPlayed": 25,
    "uniqueMediaPlayed100Percent": null
  },
  "messages": [
    {
        "seq": 1,
        "impression": 42,
        "mediaPlayed": 30,
        "mediaPlayed25Percent": null,
        "mediaPlayed50Percent": null,
        "mediaPlayed75Percent": null,
        "mediaPlayed100Percent": null,
        "uniqueMediaPlayed": 25,
        "uniqueMediaPlayed25Percent": null,
        "uniqueMediaPlayed50Percent": null,
        "uniqueMediaPlayed75Percent": null,
        "uniqueMediaPlayed100Percent": null
    }
  ],
  "clicks": [
     {
        "seq": 1,
        "url": "https://developers.line.biz/",
        "click": 35,
        "uniqueClick": 25,
        "uniqueClickOfRequest": null
    },
    {
        "seq": 1,
        "url": "https://www.line-community.me/",
        "click": 29,
        "uniqueClick": null,
        "uniqueClickOfRequest": null
    }
  ]
}
EOS

INFO_CONTENT = <<~"EOS"
{
  "numOfCustomAggregationUnits": 22
}
EOS

UNIT_CONTENT = <<~"EOS"
{
  "customAggregationUnits": [
    "test1",
    "test2",
    "test3"
  ],
  "next": "jxEWCEEP"
}
EOS

NEXT_UNIT_CONTENT = <<~"EOS"
{
  "customAggregationUnits": [
    "test4",
    "test5",
    "test6"
  ]
}
EOS

LIMITED_UNIT_CONTENT = <<~"EOS"
{
  "customAggregationUnits": [
    "test7",
    "test8"
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

  it 'gets statistics per unit' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/insight/message/event/aggregation?customAggregationUnit=test_unit&from=20220101&to=20220131'
    stub_request(:get, uri_template).to_return { |request| {body: STATISTICS_CONTENT, status: 200} }

    client = generate_client
    response = client.get_statistics_per_unit(unit: 'test_unit', from: '20220101', to: '20220131')

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result).to eq JSON.parse(STATISTICS_CONTENT)
  end

  it 'gets number of units' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/aggregation/info'
    stub_request(:get, uri_template).to_return { |request| {body: INFO_CONTENT, status: 200} }

    client = generate_client
    response = client.get_aggregation_info

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result).to eq JSON.parse(INFO_CONTENT)
  end

  it 'gets unit names' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/aggregation/list'
    stub_request(:get, uri_template).to_return { |request| {body: UNIT_CONTENT, status: 200} }

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/aggregation/list?start={start}'
    stub_request(:get, uri_template).to_return { |request| {body: NEXT_UNIT_CONTENT, status: 200} }

    client = generate_client

    # first page
    response = client.get_aggregation_list

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['customAggregationUnits']).to eq ["test1", "test2", "test3"]
    expect(result['next']).to eq "jxEWCEEP"

    # second page
    response = client.get_aggregation_list(start: result['next'])

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['customAggregationUnits']).to eq ["test4", "test5", "test6"]
    expect(result['next']).to be nil
  end

  it 'gets limited number of unit names' do
    # without any other conditions
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/aggregation/list?limit={limit}'
    stub_request(:get, uri_template).to_return { |request| {body: LIMITED_UNIT_CONTENT, status: 200} }

    # with other conditions
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/aggregation/list?limit={limit}&start={start}'
    stub_request(:get, uri_template).to_return { |request| {body: LIMITED_UNIT_CONTENT, status: 200} }

    client = generate_client

    # without any other conditions
    response = client.get_aggregation_list(limit: 2)
    result = JSON.parse(response.body)
    expect(response).to be_a(Net::HTTPOK)
    expect(result['customAggregationUnits']).to eq ["test7", "test8"]

    # with other conditions
    response = client.get_aggregation_list(start: 'foo', limit: 2)
    result = JSON.parse(response.body)
    expect(response).to be_a(Net::HTTPOK)
    expect(result['customAggregationUnits']).to eq ["test7", "test8"]
  end
end
