require 'spec_helper'
require 'webmock/rspec'
require 'json'

WebMock.allow_net_connect!

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

  before do
    stub_request(:post, 'https://trialbot-api.line.me/v1/events').to_return { |request| {:body => request.body, :status => 200} }
  end

  it 'has a version number' do
    expect(Line::Bot::API::VERSION).not_to be nil
  end

  it 'checks user-agent' do
    request = Line::Bot::Request.new do |config|
      config.credentials    = dummy_config
    end

    expect(request.header['User-Agent']).to eq "LINE-BotSDK/#{Line::Bot::API::VERSION}"
  end

  it 'creates client and checks credentials' do
    channel_id = dummy_config[:channel_id]
    channel_secret = dummy_config[:channel_secret]
    channel_mid = dummy_config[:channel_mid]
    client = Line::Bot::Client.new do |config|
      config.channel_id = channel_id
      config.channel_secret = channel_secret
      config.channel_mid = channel_mid
    end

    credentials = client.credentials
    expect(credentials['X-Line-ChannelID']).to be channel_id
    expect(credentials['X-Line-ChannelSecret']).to be channel_secret
    expect(credentials['X-Line-Trusted-User-With-ACL']).to be channel_mid
  end

  it 'creates client with arguments and checks credentials' do
    channel_id = dummy_config[:channel_id]
    channel_secret = dummy_config[:channel_secret]
    channel_mid = dummy_config[:channel_mid]
    client = Line::Bot::Client.new(
      channel_id: channel_id,
      channel_secret: channel_secret,
      channel_mid: channel_mid,
    )

    credentials = client.credentials
    expect(credentials['X-Line-ChannelID']).to be channel_id
    expect(credentials['X-Line-ChannelSecret']).to be channel_secret
    expect(credentials['X-Line-Trusted-User-With-ACL']).to be channel_mid
  end


  it 'sends text message' do
    client = generate_client

    to_mid = "1"
    text   = "text"

    result = client.send_text(to_mid: to_mid, text: text)

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]
    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::TEXT
    expect(body['content']['text']).to eq text
  end

  it 'sends text message when client doent have credentials' do
    client = Line::Bot::Client.new

    expect {
      client.send_text(to_mid: "to_mid", text: "text")
    }.to raise_error(Line::Bot::API::InvalidCredentialsError)
  end

  it 'sends text message when to_mid is wrong value' do
    client = generate_client

    to_mid = nil
    text   = "text"

    expect {
      client.send_text(to_mid: nil, text: "text")
    }.to raise_error(ArgumentError)

    expect {
      client.send_text(to_mid: [], text: "text")
    }.to raise_error(ArgumentError)

    expect {
      client.send_text(to_mid: {}, text: "text")
    }.to raise_error(ArgumentError)
  end

  it 'sends image message' do
    client = generate_client

    to_mid = "1"
    image_url = "image_url"
    preview_url = "preview_url"

    result = client.send_image(to_mid: to_mid, image_url: image_url, preview_url: preview_url)

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]
    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::IMAGE
    expect(body['content']['originalContentUrl']).to eq image_url
    expect(body['content']['previewImageUrl']).to eq preview_url
  end

  it 'sends video message' do
    client = generate_client

    to_mid = "1"
    video_url = "video_url"
    preview_url = "preview_url"

    result = client.send_video(to_mid: to_mid, video_url: video_url, preview_url: preview_url)

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]

    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::VIDEO
    expect(body['content']['originalContentUrl']).to eq video_url
    expect(body['content']['previewImageUrl']).to eq preview_url
  end

  it 'sends audio message' do
    client = generate_client

    to_mid = "1"
    audio_url = "audio_url"
    duration = 120000

    result = client.send_audio(to_mid: to_mid, audio_url: audio_url, duration: duration)

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]

    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::AUDIO
    expect(body['content']['originalContentUrl']).to eq audio_url
    expect(body['content']['contentMetadata']['AUDLEN']).to eq duration.to_s
  end

  it 'sends location message' do
    client = generate_client

    to_mid = "1"
    title = "title"
    address = "address"
    latitude = 35.61823286112982
    longitude = 139.72824096679688

    result = client.send_location(to_mid: to_mid, title: title, address: address, latitude: latitude, longitude: longitude)

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]

    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::LOCATION
    expect(body['content']['text']).to eq address
    expect(body['content']['location']['title']).to eq title
    expect(body['content']['location']['latitude']).to eq latitude
    expect(body['content']['location']['longitude']).to eq longitude
  end

  it 'sends sticker message' do
    client = generate_client

    to_mid = "1"
    stkpkgid = "stkpkgid"
    stkid = "stkid"
    stkver = "stkver"

    result = client.send_sticker(to_mid: to_mid, stkpkgid: stkpkgid, stkid: stkid, stkver: stkver)

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]
    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::STICKER
    expect(body['content']['contentMetadata']['STKPKGID']).to eq stkpkgid
    expect(body['content']['contentMetadata']['STKID']).to eq stkid
    expect(body['content']['contentMetadata']['STKVER']).to eq stkver
  end

  it 'sends rich message' do
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
    ).send(
      to_mid: to_mid,
      image_url: image_url,
      alt_text: alt_text,
    )

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]
    expect(body['content']['contentType']).to eq Line::Bot::Message::ContentType::RICH_MESSAGE
    expect(body['content']['contentMetadata']['DOWNLOAD_URL']).to eq 'https://example.com/image.jpeg'
    expect(body['content']['contentMetadata']['ALT_TEXT']).to eq alt_text

    markup = JSON.parse(body['content']['contentMetadata']['MARKUP_JSON'])

    expect(markup['canvas']['height']).to eq 520

    expect(markup['images']['image1']['height']).to eq 520

    expect(markup['actions']['MANGA']['text']).to eq 'manga'
    expect(markup['actions']['MANGA']['params']['linkUri']).to eq link_url

    expect(markup['scenes']['scene1']['draws']['x']).to eq 0
    expect(markup['scenes']['scene1']['draws']['y']).to eq 0
    expect(markup['scenes']['scene1']['draws']['width']).to eq 1040
    expect(markup['scenes']['scene1']['draws']['height']).to eq 520

    expect(markup['scenes']['scene1']['listeners'][0]['action']).to eq 'MANGA'
    expect(markup['scenes']['scene1']['listeners'][0]['params']).to eq [0, 0, 520, 520]
  end

  it 'sends multiple message' do
    client = generate_client

    to_mid = "1"
    text = 'hi!'
    image_url = 'https://example.com/image.jpeg'
    video_url = 'https://example.com/video.mp4'
    audio_url = 'https://example.com/audio.m4a'
    duration  = 12000
    preview_url = 'https://example.com/preview.jpeg'
    location_title = 'title'
    latitude = 35.61823286112982
    longitude = 139.72824096679688
    stkpkgid = 1
    stkid = 1
    stkver = 100

    result = client.multiple_message.add_text(
      text: text,
    ).add_image(
      image_url: image_url,
      preview_url: preview_url,
    ).add_video(
      video_url: video_url,
      preview_url: preview_url,
    ).add_audio(
      audio_url: audio_url,
      duration: duration,
    ).add_location(
      title: 'title',
      latitude: latitude,
      longitude: longitude,
    ).add_sticker(
      stkpkgid: stkpkgid,
      stkid: stkid,
      stkver: stkver,
    ).send(
      to_mid: to_mid,
    )

    body = JSON.parse(result.body)

    expect(body['to']).to eq [to_mid]
    expect(body['eventType'].to_i).to eq Line::Bot::EventType::MULTIPLE_MESSAGE

    # Text
    expect(body['content']['messages'][0]['contentType']).to eq Line::Bot::Message::ContentType::TEXT
    expect(body['content']['messages'][0]['text']).to eq text

    # Image
    expect(body['content']['messages'][1]['contentType']).to eq Line::Bot::Message::ContentType::IMAGE
    expect(body['content']['messages'][1]['originalContentUrl']).to eq image_url
    expect(body['content']['messages'][1]['previewImageUrl']).to eq preview_url

    # Video
    expect(body['content']['messages'][2]['contentType']).to eq Line::Bot::Message::ContentType::VIDEO
    expect(body['content']['messages'][2]['originalContentUrl']).to eq video_url
    expect(body['content']['messages'][2]['previewImageUrl']).to eq preview_url

    # Audio
    expect(body['content']['messages'][3]['contentType']).to eq Line::Bot::Message::ContentType::AUDIO
    expect(body['content']['messages'][3]['originalContentUrl']).to eq audio_url
    expect(body['content']['messages'][3]['contentMetadata']['AUDLEN']).to eq duration.to_s

    # Location
    expect(body['content']['messages'][4]['contentType']).to eq Line::Bot::Message::ContentType::LOCATION
    expect(body['content']['messages'][4]['text']).to eq location_title
    expect(body['content']['messages'][4]['location']['title']).to eq location_title
    expect(body['content']['messages'][4]['location']['latitude']).to eq latitude
    expect(body['content']['messages'][4]['location']['longitude']).to eq longitude

    # Sticker
    expect(body['content']['messages'][5]['contentType']).to eq Line::Bot::Message::ContentType::STICKER
    expect(body['content']['messages'][5]['contentMetadata']['STKPKGID'].to_i).to eq stkpkgid
    expect(body['content']['messages'][5]['contentMetadata']['STKID'].to_i).to eq stkid
    expect(body['content']['messages'][5]['contentMetadata']['STKVER'].to_i).to eq stkver
  end

end
