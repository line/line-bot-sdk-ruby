require 'spec_helper'
require 'rack/mock'
require 'json'

TEXT_CONTENT = <<"EOS"
{
  "result":[
    {
      "from":"u206d25c2ea6bd87c17655609a1c37cb8",
      "fromChannel":"1341301815",
      "to":["u0cc15697597f61dd8b01cea8b027050e"],
      "toChannel":"1441301333",
      "eventType":"138311609000106303",
      "id":"ABCDEF-12345678901",
      "content":{
        "id":"325708",
        "createdTime":1332394961610,
        "from":"uff2aec188e58752ee1fb0f9507c6529a",
        "to":["u0a556cffd4da0dd89c94fb36e36e1cdc"],
        "toType":1,
        "contentType":1,
        "text":"hello"
      }
    }
  ]
}
EOS

IMAGE_CONTENT = <<"EOS"
{
  "result":[
    {
      "from":"u206d25c2ea6bd87c17655609a1c37cb8",
      "fromChannel":"1341301815",
      "to":["u0cc15697597f61dd8b01cea8b027050e"],
      "toChannel":"1441301333",
      "eventType":"138311609000106303",
      "id":"ABCDEF-12345678901",
      "content":{
        "id":"325708",
        "createdTime":1332394961610,
        "from":"uff2aec188e58752ee1fb0f9507c6529a",
        "to":["u0a556cffd4da0dd89c94fb36e36e1cdc"],
        "toType":1,
        "contentType":2
      }
    }
  ]
}
EOS

LOCATION_CONTENT = <<"EOS"
{
  "result":[
    {
      "from":"u206d25c2ea6bd87c17655609a1c37cb8",
      "fromChannel":"1341301815",
      "to":["u0cc15697597f61dd8b01cea8b027050e"],
      "toChannel":"1441301333",
      "eventType":"138311609000106303",
      "id":"ABCDEF-12345678901",
      "content":{
        "id":"325708",
        "createdTime":1332394961610,
        "from":"uff2aec188e58752ee1fb0f9507c6529a",
        "to":["u0a556cffd4da0dd89c94fb36e36e1cdc"],
        "toType":1,
        "contentType":7,
        "location": {
          "title":"位置情報",
          "address":" 〒123-4567 東京都○○区",
          "latitude": 35.61823286112982,
          "longitude": 139.72824096679688
        }
      }
    }
  ]
}
EOS

STICKER_CONTENT = <<"EOS"
{
  "result":[
    {
      "from":"u206d25c2ea6bd87c17655609a1c37cb8",
      "fromChannel":"1341301815",
      "to":["u0cc15697597f61dd8b01cea8b027050e"],
      "toChannel":"1441301333",
      "eventType":"138311609000106303",
      "id":"ABCDEF-12345678901",
      "content":{
        "id":"325708",
        "createdTime":1332394961610,
        "from":"uff2aec188e58752ee1fb0f9507c6529a",
        "to":["u0a556cffd4da0dd89c94fb36e36e1cdc"],
        "toType":1,
        "contentType":8,
        "contentMetadata":{
          "STKTXT":"[]",
          "AT_RECV_MODE":"2",
          "STKVER":"1",
          "STKOPT":"A",
          "STKID":"2",
          "STKPKGID":"1"
        }
      }
    }
  ]
}
EOS

OPERATION_CONTENT = <<"EOS"
{
  "result":[
    {
      "from":"u206d25c2ea6bd87c17655609a1c37cb8",
      "fromChannel":"1341301815",
      "to":["u0cc15697597f61dd8b01cea8b027050e"],
      "toChannel":"1441301333",
      "eventType":"138311609100106403",
      "id":"ABCDEF-12345678902",
      "content":{
        "revision":2469,
        "opType":4,
        "params":[
          "u0f3bfc598b061eba02183bfc5280886a",
          null,
          null
        ]
      }
    }
  ]
}
EOS

describe Line::Bot::Receive do

  def dummy_config
    {
      channel_id: 1441301333,
      channel_secret: 'testsecret',
      channel_mid: 'u0a556cffd4da0dd89c94fb36e36e1cdc',
    }
  end

  def generate_client
    client = Line::Bot::Client.new do |config|
      config.channel_id = dummy_config[:channel_id]
      config.channel_secret = dummy_config[:channel_secret]
      config.channel_mid = dummy_config[:channel_mid]
    end

    client
  end

  def generate_request(content)
    dummy_env = Rack::MockRequest.env_for("https://example.com:443/callback", input: content)

    Line::Bot::Receive::Request.new(dummy_env)
  end

  it 'receives text message' do
    request = generate_request(TEXT_CONTENT)
    expect(request.data.size).to eq 1

    message = request.data.first
    expect(message).to be_a(Line::Bot::Receive::Message)
    expect(message.id).to eq "325708"

    content = message.content
    expect(content).to be_a(Line::Bot::Message::Text)

    expect(message.created_time.to_i).to eq 1332394961
    expect(message.created_time.usec).to eq 610

    expect(content[:text]).to eq "hello"
  end

  it 'receives image message' do
    request = generate_request(IMAGE_CONTENT)
    expect(request.data.size).to eq 1

    message = request.data.first
    expect(message).to be_a(Line::Bot::Receive::Message)
    expect(message.id).to eq "325708"

    expect(message.created_time.to_i).to eq 1332394961
    expect(message.created_time.usec).to eq 610

    content = message.content
    expect(content).to be_a(Line::Bot::Message::Image)
  end

  it 'receives location message' do
    request = generate_request(LOCATION_CONTENT)
    expect(request.data.size).to eq 1

    message = request.data.first
    expect(message).to be_a(Line::Bot::Receive::Message)
    expect(message.id).to eq "325708"

    expect(message.created_time.to_i).to eq 1332394961
    expect(message.created_time.usec).to eq 610

    content = message.content
    expect(content).to be_a(Line::Bot::Message::Location)

    expect(content[:title]).to eq "位置情報"
    expect(content[:address]).to eq " 〒123-4567 東京都○○区"
    expect(content[:latitude]).to eq 35.61823286112982
    expect(content[:longitude]).to eq 139.72824096679688
  end

  it 'receives sticker message' do
    request = generate_request(STICKER_CONTENT)
    expect(request.data.size).to eq 1

    message = request.data.first
    expect(message).to be_a(Line::Bot::Receive::Message)
    expect(message.id).to eq "325708"

    expect(message.created_time.to_i).to eq 1332394961
    expect(message.created_time.usec).to eq 610

    content = message.content
    expect(content).to be_a(Line::Bot::Message::Sticker)

    expect(content[:stkpkgid]).to eq "1"
    expect(content[:stkid]).to eq "2"
    expect(content[:stkver]).to eq "1"
  end

  it 'receives operation' do
    request = generate_request(OPERATION_CONTENT)
    expect(request.data.size).to eq 1

    operation = request.data.first
    expect(operation).to be_a(Line::Bot::Receive::Operation)

    expect(operation.from_mid).to eq "u0f3bfc598b061eba02183bfc5280886a"
    expect(operation.to_mid).to eq ["u0cc15697597f61dd8b01cea8b027050e"]
    expect(operation.from_channel_id).to eq "1341301815"
    expect(operation.to_channel_id).to eq "1441301333"

    content = operation.content
    expect(content).to be_a(Line::Bot::Operation::AddFriend)

    expect(content[:params]).to eq ["u0f3bfc598b061eba02183bfc5280886a", nil, nil]
    expect(content[:op_type]).to eq Line::Bot::Operation::OpType::ADD_FRIEND
  end
end
