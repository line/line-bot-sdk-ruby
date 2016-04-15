require 'spec_helper'
require 'json'

describe Line::Bot::Builder::MultipleMessage do

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

  it 'generates multiple message' do
    client = generate_client

    expect {
      client.multiple_message.add_text({})
    }.to raise_error(ArgumentError)

    expect {
      client.multiple_message.add_image({})
    }.to raise_error(ArgumentError)

    expect {
      client.multiple_message.add_video({})
    }.to raise_error(ArgumentError)

    expect {
      client.multiple_message.add_audio({})
    }.to raise_error(ArgumentError)

    expect {
      client.multiple_message.add_location({})
    }.to raise_error(ArgumentError)

    expect {
      client.multiple_message.add_sticker({})
    }.to raise_error(ArgumentError)

  end

end
