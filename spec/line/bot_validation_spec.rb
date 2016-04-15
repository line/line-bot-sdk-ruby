require 'spec_helper'
require 'json'

CONTENT = <<"EOS"
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
    },
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

describe Line::Bot do

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

  it 'validates signature to success' do
    client = generate_client

    result = client.validate_signature(CONTENT, 'YdUyzEMBcQwsneRE8RkWm9/3AF+Zms+Mj1sh7d/biuc=')

    expect(result).to be_truthy
  end

  it 'validates signature to failure' do
    client = generate_client

    result = client.validate_signature(CONTENT, '')

    expect(result).to be_falsey
  end

end
