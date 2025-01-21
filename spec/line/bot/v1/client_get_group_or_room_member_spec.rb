require 'spec_helper'
require 'webmock/rspec'
require 'json'

MEMBER_ID_CONTENT = <<"EOS"
{
    "memberIds": [
        "Uxxxxxxxxxxxxxx1",
        "Uxxxxxxxxxxxxxx2",
        "Uxxxxxxxxxxxxxx3"
    ],
    "next": "jxEWCEEP"
}
EOS

NEXT_MEMBER_ID_CONTENT = <<"EOS"
{
    "memberIds": [
        "Uxxxxxxxxxxxxxx4",
        "Uxxxxxxxxxxxxxx5",
        "Uxxxxxxxxxxxxxx6"
    ]
}
EOS

GROUP_ROOM_MEMBER_PROFILE_CONTENT = <<"EOS"
{
    "displayName":"LINE taro",
    "userId":"Uxxxxxxxxxxxxxx11",
    "pictureUrl":"http://obs.line-apps.com/image"
}
EOS

GROUP_SUMMARY = <<"EOS"
{
    "groupId": "group_id",
    "groupName": "Group name",
    "pictureUrl":"https://example.com/abcdefghijklmn"
}
EOS

GROUP_MEMBERS_COUNT = <<"EOS"
{
   "count": 3
}
EOS

ROOM_MEMBERS_COUNT = <<"EOS"
{
   "count": 3
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

  it 'gets room member ids' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/room/{roomId}/members/ids'
    stub_request(:get, uri_template).to_return { |request| {body: MEMBER_ID_CONTENT, status: 200} }

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/room/{roomId}/members/ids?start={continuationToken}'
    stub_request(:get, uri_template).to_return { |request| {body: NEXT_MEMBER_ID_CONTENT, status: 200} }

    client = generate_client
    room_id = "room_id"

    # first page
    response = client.get_room_member_ids(room_id)

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['memberIds']).to eq ["Uxxxxxxxxxxxxxx1", "Uxxxxxxxxxxxxxx2", "Uxxxxxxxxxxxxxx3"]
    expect(result['next']).to eq "jxEWCEEP"

    # second page
    response = client.get_room_member_ids(room_id, result['next'])

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['memberIds']).to eq ["Uxxxxxxxxxxxxxx4", "Uxxxxxxxxxxxxxx5", "Uxxxxxxxxxxxxxx6"]
    expect(result['next']).to be nil
  end

  it 'gets group member ids' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/group/{groupId}/members/ids'
    stub_request(:get, uri_template).to_return { |request| {body: MEMBER_ID_CONTENT, status: 200} }

    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/group/{groupId}/members/ids?start={continuationToken}'
    stub_request(:get, uri_template).to_return { |request| {body: NEXT_MEMBER_ID_CONTENT, status: 200} }

    client = generate_client
    group_id = "group_id"

    # first page
    response = client.get_group_member_ids(group_id)

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['memberIds']).to eq ["Uxxxxxxxxxxxxxx1", "Uxxxxxxxxxxxxxx2", "Uxxxxxxxxxxxxxx3"]
    expect(result['next']).to eq "jxEWCEEP"

    # second page
    response = client.get_group_member_ids(group_id, result['next'])

    expect(response).to be_a(Net::HTTPOK)
    result = JSON.parse(response.body)
    expect(result['memberIds']).to eq ["Uxxxxxxxxxxxxxx4", "Uxxxxxxxxxxxxxx5", "Uxxxxxxxxxxxxxx6"]
    expect(result['next']).to be nil
  end

  it 'gets room member profile' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/room/{roomId}/member/{userId}'
    stub_request(:get, uri_template).to_return { |request| {body: GROUP_ROOM_MEMBER_PROFILE_CONTENT, status: 200} }

    client = generate_client
    room_id = "room_id"
    user_id = "Uxxxxxxxxxxxxxx11"

    response = client.get_room_member_profile(room_id, user_id)

    contact = JSON.parse(response.body)
    expect(contact['userId']).to eq "Uxxxxxxxxxxxxxx11"
    expect(contact['displayName']).to eq "LINE taro"
    expect(contact['pictureUrl']).to eq "http://obs.line-apps.com/image"
  end

  it 'gets group member profile' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/group/{groupId}/member/{userId}'
    stub_request(:get, uri_template).to_return { |request| {body: GROUP_ROOM_MEMBER_PROFILE_CONTENT, status: 200} }

    client = generate_client
    group_id = "group_id"
    user_id = "Uxxxxxxxxxxxxxx11"

    response = client.get_group_member_profile(group_id, user_id)

    contact = JSON.parse(response.body)
    expect(contact['userId']).to eq "Uxxxxxxxxxxxxxx11"
    expect(contact['displayName']).to eq "LINE taro"
    expect(contact['pictureUrl']).to eq "http://obs.line-apps.com/image"
  end

  it 'gets group summary' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/group/{groupId}/summary'
    stub_request(:get, uri_template).to_return { |request| {body: GROUP_SUMMARY, status: 200} }

    client = generate_client
    group_id = "group_id"

    response = client.get_group_summary(group_id)

    contact = JSON.parse(response.body)
    expect(contact['groupId']).to eq "group_id"
    expect(contact['groupName']).to eq "Group name"
    expect(contact['pictureUrl']).to eq "https://example.com/abcdefghijklmn"
  end

  it 'gets group members count' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/group/{groupId}/members/count'
    stub_request(:get, uri_template).to_return { |request| {body: GROUP_MEMBERS_COUNT, status: 200} }

    client = generate_client
    group_id = "group_id"

    response = client.get_group_members_count(group_id)

    contact = JSON.parse(response.body)
    expect(contact['count']).to eq 3
  end

  it 'gets group members count' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/room/{roomId}/members/count'
    stub_request(:get, uri_template).to_return { |request| {body: ROOM_MEMBERS_COUNT, status: 200} }

    client = generate_client
    room_id = "room_id"

    response = client.get_room_members_count(room_id)

    contact = JSON.parse(response.body)
    expect(contact['count']).to eq 3
  end
end
