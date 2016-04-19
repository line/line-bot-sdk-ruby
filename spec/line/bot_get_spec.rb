require 'spec_helper'
require 'webmock/rspec'
require 'json'

PROFILES_CONTENT = <<"EOS"
{
  "contacts": [
    {
      "displayName":"BOT API1",
      "mid":"u0047556f2e40dba2456887320ba7c76d",
      "pictureUrl":"http://dl.profile.line.naver.jp/abcdefghijklmn",
      "statusMessage":"Hello, LINE!"
    },
    {
      "displayName":"BOT API2",
      "mid":"u0047556f2e40dba2456887320ba7c76e",
      "pictureUrl":"http://dl.profile.line.naver.jp/12345678",
      "statusMessage":"Hello, LINE+!"
    }
  ],
  "count":2,
  "display":4,
  "start":1,
  "total":3
}
EOS

WebMock.allow_net_connect!

describe "Line::Bot Get" do

  before do
  end

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

  it 'gets message content' do
    uri_template = Addressable::Template.new 'https://trialbot-api.line.me/v1/bot/message/{identifer}/content'
    stub_request(:get, uri_template).to_return { |request| {:body => request.body, :status => 200} }

    client = generate_client

    response = client.get_message_content(1234567)
    expect(response).to be_a(Net::HTTPOK)
  end

  it 'gets preview of message content' do
    uri_template = Addressable::Template.new 'https://trialbot-api.line.me/v1/bot/message/{identifer}/content/preview'
    stub_request(:get, uri_template).to_return { |request| {:body => request.body, :status => 200} }

    client = generate_client

    response = client.get_message_content_preview(1234567)
    expect(response).to be_a(Net::HTTPOK)
  end

  it 'gets user profile information' do
    uri_template = Addressable::Template.new 'https://trialbot-api.line.me/v1/profiles?mids={mids}'
    stub_request(:get, uri_template).to_return { |request| {:body => PROFILES_CONTENT, :status => 200} }

    client = generate_client

    user_profile = client.get_user_profile("1234567")
    expect(user_profile.start).to eq 1
    expect(user_profile.count).to eq 2
    expect(user_profile.total).to eq 3
    expect(user_profile.display).to eq 4

    contacts = user_profile.contacts
    expect(contacts[0].mid).to eq "u0047556f2e40dba2456887320ba7c76d"
    expect(contacts[0].display_name).to eq "BOT API1"
    expect(contacts[0].picture_url).to eq "http://dl.profile.line.naver.jp/abcdefghijklmn"
    expect(contacts[0].status_message).to eq "Hello, LINE!"

    expect(contacts[1].mid).to eq "u0047556f2e40dba2456887320ba7c76e"
    expect(contacts[1].display_name).to eq "BOT API2"
    expect(contacts[1].picture_url).to eq "http://dl.profile.line.naver.jp/12345678"
    expect(contacts[1].status_message).to eq "Hello, LINE+!"
  end

  it 'gets user profile information' do
    client = generate_client

    expect {
      client.get_user_profile(nil)
    }.to raise_error(ArgumentError)
  end

end
