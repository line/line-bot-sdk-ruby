require 'spec_helper'
require 'json'

describe Line::Bot::Builder::RichMessage do

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

  it 'generates rich message' do
    client = generate_client

    image_url = 'https://example.com/image.jpeg'
    to_mid = "1"
    alt_text = 'This is a alt text.'
    link_url = 'https://store.line.me/family/manga/en'

    result = client.rich_message.set_action(
      MANGA: {
        text: 'manga',
        link_url: link_url,
      }
    ).add_listener(
      action: 'MANGA',
      x: 0,
      y: 0,
      width: 520,
      height: 520,
    )
  end

  it 'generates rich message then forgets link_url' do
    client = generate_client

    expect {
      client.rich_message.set_action(
        MANGA: {
          text: 'manga',
        }
      )
    }.to raise_error(ArgumentError)
  end

  it 'generates rich message then forgets height in add_listener' do
    client = generate_client

    image_url = 'https://example.com/image.jpeg'

    expect {
      client.rich_message.add_listener(
        action: 'MANGA',
        x: 0,
        y: 0,
        width: 520,
      )
    }.to raise_error(ArgumentError)
  end

  it "generates rich message then misses width's type in add_listener" do
    client = generate_client

    image_url = 'https://example.com/image.jpeg'

    expect {
      client.rich_message.add_listener(
        action: 'MANGA',
        x: 0,
        y: 0,
        width: "520",
        height: 520,
      )
    }.to raise_error(ArgumentError)
  end

end
