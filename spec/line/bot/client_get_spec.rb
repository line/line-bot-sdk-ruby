require 'spec_helper'
require 'webmock/rspec'
require 'json'

PROFILE_CONTENT = <<"EOS"
{
  "displayName":"BOT API",
  "userId":"u0047556f2e40dba2456887320ba7c76d",
  "pictureUrl":"http://dl.profile.line.naver.jp/abcdefghijklmn",
  "statusMessage":"Hello, LINE!"
}
EOS

OTHER_PROFILE_CONTENT = <<"EOS"
{
  "userId":"Ufr47556f2e40dba2456887320ba7c76d",
  "displayName":"Brown",
  "pictureUrl":"https://example.com/abcdefghijklmn",
  "statusMessage":"Hello, LINE!"
}
EOS

DELIVERY_NUMBER_CONTENT = <<"EOS"
{
  "status": "ready",
  "success": 1
}
EOS

QUOTA_CONTENT = <<"EOS"
{
  "type":"none"
}
EOS

QUOTA_CONSUMPTION_CONTENT = <<"EOS"
{
  "totalUsage":1
}
EOS

NUMBER_OF_MESSAGE_DELIVERY_CONTENT = <<"EOS"
{
  "status": "ready",
  "broadcast": 5385,
  "targeting": 522,
  "autoResponse": 123,
  "welcomeResponse": 456,
  "chat": 789,
  "apiBroadcast": 1123,
  "apiPush": 1234,
  "apiMulticast": 1567,
  "apiReply": 1890
}
EOS

NUMBER_OF_FOLLOWERS_CONTENT = <<"EOS"
{
  "status": "ready",
  "followers": 5385,
  "targetedReaches": 522,
  "blocks": 123
}
EOS

FRIEND_DEMOGRAPHIC_CONTENT = <<"EOS"
{
    "available": true,
    "genders": [
        {
            "gender": "unknown",
            "percentage": 37.6
        },
        {
            "gender": "male",
            "percentage": 31.8
        },
        {
            "gender": "female",
            "percentage": 30.6
        }
    ],
    "ages": [
        {
            "age": "unknown",
            "percentage": 37.6
        },
        {
            "age": "from50",
            "percentage": 17.3
        }
    ],
    "areas": [
        {
            "area": "unknown",
            "percentage": 42.9
        },
        {
            "area": "徳島",
            "percentage": 2.9
        }
    ],
    "appTypes": [
        {
            "appType": "ios",
            "percentage": 62.4
        },
        {
            "appType": "android",
            "percentage": 27.7
        },
        {
            "appType": "others",
            "percentage": 9.9
        }
    ],
    "subscriptionPeriods": [
        {
            "subscriptionPeriod": "over365days",
            "percentage": 96.4
        },
        {
            "subscriptionPeriod": "within365days",
            "percentage": 1.9
        },
        {
            "subscriptionPeriod": "within180days",
            "percentage": 1.2
        },
        {
            "subscriptionPeriod": "within90days",
            "percentage": 0.5
        },
        {
            "subscriptionPeriod": "within30days",
            "percentage": 0.1
        },
        {
            "subscriptionPeriod": "within7days",
            "percentage": 0
        }
    ]
}
EOS

USER_INTERACTION_STATISTICS_CONTENT = <<EOS
{
    "overview": {
        "requestId": "f70dd685-499a-4231-a441-f24b8d4fba21",
        "timestamp": 1568214000,
        "delivered": 32,
        "uniqueImpression": 4,
        "uniqueClick": null,
        "uniqueMediaPlayed": 2,
        "uniqueMediaPlayed100Percent": -1
    },
    "messages": [
        {
            "seq": 1,
            "impression": 18,
            "mediaPlayed": 11,
            "mediaPlayed25Percent": -1,
            "mediaPlayed50Percent": -1,
            "mediaPlayed75Percent": -1,
            "mediaPlayed100Percent": -1,
            "uniqueMediaPlayed": 2,
            "uniqueMediaPlayed25Percent": -1,
            "uniqueMediaPlayed50Percent": -1,
            "uniqueMediaPlayed75Percent": -1,
            "uniqueMediaPlayed100Percent": -1
        }
    ],
    "clicks": [
        {
            "seq": 1,
            "url": "https://example.com/1",
            "click": -1,
            "uniqueClick": -1,
            "uniqueClickOfRequest": -1
        },
        {
            "seq": 1,
            "url": "https://example.com/2",
            "click": -1,
            "uniqueClick": -1,
            "uniqueClickOfRequest": -1
        }
    ]
}
EOS

BOT_INFO_CONTENT = <<"EOS"
{
  "userId": "Ufr47556f2e40dba2456887320ba7c76d",
  "basicId": "@abcdefghijklmn",
  "displayName": "Example",
  "pictureUrl": "https://example.com/hogehoge",
  "chatMode": "chat",
  "markAsReadMode": "manual"
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

  it 'gets message content' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/message/{identifier}/content'
    stub_request(:get, uri_template).to_return { |request| {body: request.body, status: 200} }

    client = generate_client

    response = client.get_message_content(1234567)
    expect(response).to be_a(Net::HTTPOK)
  end

  it 'gets profile' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/profile/{user_id}'
    stub_request(:get, uri_template).to_return { |request| {body: PROFILE_CONTENT, status: 200} }

    client = generate_client

    response = client.get_profile("1234567")

    contact = JSON.parse(response.body)
    expect(contact['userId']).to eq "u0047556f2e40dba2456887320ba7c76d"
    expect(contact['displayName']).to eq "BOT API"
    expect(contact['pictureUrl']).to eq "http://dl.profile.line.naver.jp/abcdefghijklmn"
    expect(contact['statusMessage']).to eq "Hello, LINE!"
  end

  it 'gets other path' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/profile'
    stub_request(:get, uri_template).to_return { |request| {body: OTHER_PROFILE_CONTENT, status: 200} }

    client = generate_client

    response = client.get(Line::Bot::API::DEFAULT_ENDPOINT, '/profile')

    contact = JSON.parse(response.body)
    expect(contact['displayName']).to eq "Brown"
  end

  it "gets the number of reply messages sent" do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/delivery/reply?date={sent_date}'
    stub_request(:get, uri_template).to_return(body: DELIVERY_NUMBER_CONTENT, status: 200)

    client = generate_client
    response = client.get_message_delivery_reply("20190101")

    delivery = JSON.parse(response.body)
    expect(delivery['status']).to eq "ready"
    expect(delivery['success']).to eq 1
  end

  it "gets the number of push messages sent" do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/delivery/push?date={sent_date}'
    stub_request(:get, uri_template).to_return(body: DELIVERY_NUMBER_CONTENT, status: 200)

    client = generate_client
    response = client.get_message_delivery_push("20190101")

    delivery = JSON.parse(response.body)
    expect(delivery['status']).to eq "ready"
    expect(delivery['success']).to eq 1
  end

  it "gets the number of multicast messages sent" do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/delivery/multicast?date={send_date}'
    stub_request(:get, uri_template).to_return(body: DELIVERY_NUMBER_CONTENT, status: 200)

    client = generate_client
    response = client.get_message_delivery_multicast("20190101")

    delivery = JSON.parse(response.body)
    expect(delivery['status']).to eq "ready"
    expect(delivery['success']).to eq 1
  end

  it "gets the number of broadcast messages sent" do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/delivery/broadcast?date={send_date}'
    stub_request(:get, uri_template).to_return(body: DELIVERY_NUMBER_CONTENT, status: 200)

    client = generate_client
    response = client.get_message_delivery_broadcast("20190101")

    delivery = JSON.parse(response.body)
    expect(delivery['status']).to eq "ready"
    expect(delivery['success']).to eq 1
  end

  it "gets number of messages sent whithout date will raise error" do
    client = generate_client

    expect { client.get_message_delivery_reply }.to raise_error(ArgumentError)
    expect { client.get_message_delivery_push }.to raise_error(ArgumentError)
    expect { client.get_message_delivery_multicast }.to raise_error(ArgumentError)
  end

  it 'gets number of quota' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/quota'
    stub_request(:get, uri_template).to_return(body: QUOTA_CONTENT, status: 200)

    client = generate_client
    response = client.get_quota

    quota = JSON.parse(response.body)
    expect(quota['type']).to eq 'none'
  end

  it 'gets number of quota consumption' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/quota/consumption'
    stub_request(:get, uri_template).to_return(body: QUOTA_CONSUMPTION_CONTENT, status: 200)

    client = generate_client
    response = client.get_quota_consumption

    quota = JSON.parse(response.body)
    expect(quota['totalUsage']).to eq 1
  end

  it 'get number of message deliveries' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/insight/message/delivery?date=20190701'
    stub_request(:get, uri_template).to_return(body: NUMBER_OF_MESSAGE_DELIVERY_CONTENT, status: 200)

    client = generate_client
    response = client.get_number_of_message_deliveries("20190701")

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq(
      status: "ready",
      broadcast: 5385,
      targeting: 522,
      autoResponse: 123,
      welcomeResponse: 456,
      chat: 789,
      apiBroadcast: 1123,
      apiPush: 1234,
      apiMulticast: 1567,
      apiReply: 1890
    )
  end

  it 'get number of followers' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/insight/followers?date=20190701'
    stub_request(:get, uri_template).to_return(body: NUMBER_OF_FOLLOWERS_CONTENT, status: 200)

    client = generate_client
    response = client.get_number_of_followers("20190701")

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq(
      status: "ready",
      followers: 5385,
      targetedReaches: 522,
      blocks: 123
    )
  end

  it 'get friend demographics' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/insight/demographic'
    stub_request(:get, uri_template).to_return(body: FRIEND_DEMOGRAPHIC_CONTENT, status: 200)

    client = generate_client
    response = client.get_friend_demographics

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq(
      available: true,
      genders: [
        { gender: "unknown", percentage: 37.6 },
        { gender: "male",    percentage: 31.8 },
        { gender: "female",  percentage: 30.6 }
      ],
      ages: [
        { age: "unknown", percentage: 37.6 },
        { age: "from50", percentage: 17.3 },
      ],
      areas: [
        { area: "unknown", percentage: 42.9 },
        { area: "徳島",    percentage: 2.9 }
      ],
      appTypes: [
        { appType: "ios",     percentage: 62.4 },
        { appType: "android", percentage: 27.7 },
        { appType: "others",  percentage: 9.9 }
      ],
      subscriptionPeriods: [
        { subscriptionPeriod: "over365days",   percentage: 96.4 },
        { subscriptionPeriod: "within365days", percentage: 1.9 },
        { subscriptionPeriod: "within180days", percentage: 1.2 },
        { subscriptionPeriod: "within90days",  percentage: 0.5 },
        { subscriptionPeriod: "within30days",  percentage: 0.1 },
        { subscriptionPeriod: "within7days",   percentage: 0 }
      ]
    )
  end

  it 'get user interaction statistics' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/insight/message/event?requestId=f70dd685-499a-4231-a441-f24b8d4fba21'
    stub_request(:get, uri_template).to_return(body: USER_INTERACTION_STATISTICS_CONTENT, status: 200)

    client = generate_client
    response = client.get_user_interaction_statistics('f70dd685-499a-4231-a441-f24b8d4fba21')

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq(
      overview: {
        requestId: 'f70dd685-499a-4231-a441-f24b8d4fba21',
        timestamp: 1568214000,
        delivered: 32,
        uniqueImpression: 4,
        uniqueClick: nil,
        uniqueMediaPlayed: 2,
        uniqueMediaPlayed100Percent: -1
      },
      messages: [
        {
          seq: 1,
          impression: 18,
          mediaPlayed: 11,
          mediaPlayed25Percent: -1,
          mediaPlayed50Percent: -1,
          mediaPlayed75Percent: -1,
          mediaPlayed100Percent: -1,
          uniqueMediaPlayed: 2,
          uniqueMediaPlayed25Percent: -1,
          uniqueMediaPlayed50Percent: -1,
          uniqueMediaPlayed75Percent: -1,
          uniqueMediaPlayed100Percent: -1
        }
      ],
      clicks: [
        {
          seq: 1,
          url: 'https://example.com/1',
          click: -1,
          uniqueClick: -1,
          uniqueClickOfRequest: -1
        },
        {
          seq: 1,
          url: 'https://example.com/2',
          click: -1,
          uniqueClick: -1,
          uniqueClickOfRequest: -1
        }
      ]
    )
  end

  it 'get bot info' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/info'
    stub_request(:get, uri_template).to_return(body: BOT_INFO_CONTENT, status: 200)

    client = generate_client
    response = client.get_bot_info

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json).to eq(
      userId: 'Ufr47556f2e40dba2456887320ba7c76d',
      basicId: '@abcdefghijklmn',
      displayName: 'Example',
      pictureUrl: 'https://example.com/hogehoge',
      chatMode: 'chat',
      markAsReadMode: 'manual'
    )
  end
end
