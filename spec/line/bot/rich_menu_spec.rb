require 'spec_helper'
require 'webmock/rspec'
require 'json'
require 'tempfile'

RICH_MENU_CONTENT = <<"EOS"
{
  "richMenuId": "1234567",
  "size": {
     "width": 2500,
     "height": 1686
   },
   "selected": false,
   "areas": [
     {
       "bounds": {
         "x": 0,
         "y": 0,
         "width": 2500,
         "height": 1686
       },
       "action": {
         "type": "postback",
         "data": "action=buy&itemid=123"
       }
     }
   ]
}
EOS

RICH_MENU_LIST_CONTENT = <<"EOS"
{
  "richmenus": [
    #{RICH_MENU_CONTENT}
  ]
}
EOS

RICH_MENU_IMAGE_FILE_PATH = 'spec/fixtures/line/bot/rich_menu_01.png'
RICH_MENU_INVALID_FILE_EXTENSION_PATH = 'spec/fixtures/line/bot/rich_menu_01.txt'

WebMock.allow_net_connect!

describe Line::Bot::Client do
  let(:client) {
    dummy_config = {
      channel_token: 'access token',
    }
    Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  }

  it 'gets a list of rich menus' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/list'
    stub_request(:get, uri_template).to_return(body: RICH_MENU_LIST_CONTENT, status: 200)

    response = client.get_rich_menus
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/list')
    expect(response.body).to eq RICH_MENU_LIST_CONTENT
  end

  it 'gets a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567'
    stub_request(:get, uri_template).to_return(body: RICH_MENU_CONTENT, status: 200)

    response = client.get_rich_menu('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567')
    expect(response.body).to eq RICH_MENU_CONTENT
  end

  it 'creates a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu'
    stub_request(:post, uri_template).to_return(body: RICH_MENU_CONTENT, status: 200)

    client.create_rich_menu(JSON.parse(RICH_MENU_CONTENT))
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu')
      .with(body: JSON.parse(RICH_MENU_CONTENT).to_json)
  end

  it 'deletes a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    client.delete_rich_menu('1234567')
    expect(WebMock).to have_requested(:delete, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567')
  end

  it 'gets rich menu linked to a user' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu'
    stub_request(:get, uri_template).to_return(body: '{"richMenuId":"7654321"}', status: 200)

    response = client.get_user_rich_menu('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu')
    expect(response.body).to eq '{"richMenuId":"7654321"}'
  end

  it 'set a default rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/all/richmenu/7654321'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.set_default_rich_menu('7654321')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/all/richmenu/7654321')
  end

  it 'get the default rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/all/richmenu'
    stub_request(:get, uri_template).to_return(body: '{"richMenuId":"76543210"}', status: 200)

    response = client.get_default_rich_menu
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/all/richmenu')
    expect(response.body).to eq '{"richMenuId":"76543210"}'
  end

  it 'unset a default rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/all/richmenu'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    client.unset_default_rich_menu
    expect(WebMock).to have_requested(:delete, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/all/richmenu')
  end

  it 'links a rich menu to a user' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu/7654321'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.link_user_rich_menu('1234567', '7654321')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu/7654321')
  end

  it 'unlinks a rich menu from a user' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    client.unlink_user_rich_menu('1234567')
    expect(WebMock).to have_requested(:delete, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu')
  end

  it 'link a rich menu to multiple users at a atime' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/bulk/link'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.bulk_link_rich_menus(['1', '2'], '7654321')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/bulk/link')
  end

  it 'unlink a rich menu from multiple users at a time' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/bulk/unlink'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.bulk_unlink_rich_menus(['1', '2'])
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/bulk/unlink')
  end

  it 'gets an image associated with a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:get, uri_template).to_return(body: File.open(RICH_MENU_IMAGE_FILE_PATH).read, status: 200)

    response = client.get_rich_menu_image('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content')
    expect(response.body).to eq File.open(RICH_MENU_IMAGE_FILE_PATH).read
  end

  it 'uploads and attaches an image to a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'

    stub_request(:post, uri_template).to_return(body: '{}', status: 200).with { |request|
      expect(request.headers["Content-Type"]).to eq('image/png')
    }

    File.open(RICH_MENU_IMAGE_FILE_PATH) do |image_file|
      client.create_rich_menu_image('1234567', image_file)
    end

    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content')
      .with(body: File.open(RICH_MENU_IMAGE_FILE_PATH).read)
  end

  it "uploads invalid extension's file" do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)
    expect {
      File.open(RICH_MENU_INVALID_FILE_EXTENSION_PATH) do |file|
        client.create_rich_menu_image('1234567', file)
      end
    }.to raise_error(ArgumentError)
  end
end
