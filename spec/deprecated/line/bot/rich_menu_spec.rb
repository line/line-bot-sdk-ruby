require 'spec_helper'
require 'webmock/rspec'
require 'json'
require 'tempfile'
require 'open-uri'

RICH_MENU_CONTENT = <<"EOS"
{
  "size": {
     "width": 2500,
     "height": 1686
   },
   "selected": false,
   "name": "Nice richmenu",
   "chatBarText": "Tap here",
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

RICH_MENU_ALIAS_CONTENT = <<"EOS"
{
  {
    "richMenuAliasId": "alias-1234567",
    "richMenuId": "1234567"
  }
}
EOS

RICH_MENU_ALIAS_LIST_CONTENT = <<"EOS"
{
  "aliases": [
    #{RICH_MENU_ALIAS_CONTENT}
  ]
}
EOS

RICH_MENU_IMAGE_FILE_PATH = 'spec/deprecated/fixtures/line/bot/rich_menu_01.png'
RICH_MENU_INVALID_FILE_EXTENSION_PATH = 'spec/deprecated/fixtures/line/bot/rich_menu_01.txt'

describe Line::Bot::Client do
  let(:client) do
    dummy_config = {
      channel_token: 'access token',
    }
    Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  end

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

  it 'validates a rich menu object' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/validate'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.validate_rich_menu_object(JSON.parse(RICH_MENU_CONTENT))
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/validate')
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

  it 'creates a rich menu alias' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.set_rich_menus_alias('1234567', 'alias-1234567')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias')
  end

  it 'deletes a rich menu alias' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/alias-1234567'
    stub_request(:delete, uri_template).to_return(body: '{}', status: 200)

    client.unset_rich_menus_alias('alias-1234567')
    expect(WebMock).to have_requested(:delete, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/alias-1234567')
  end

  it 'update a rich menu alias' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/alias-1234567'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    client.update_rich_menus_alias('1234567', 'alias-1234567')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/alias-1234567')
  end

  it 'get a rich menu alias' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/alias-1234567'
    stub_request(:get, uri_template).to_return(body: RICH_MENU_ALIAS_CONTENT, status: 200)

    client.get_rich_menus_alias('alias-1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/alias-1234567')
  end

  it 'get a rich menu alias list' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/list'
    stub_request(:get, uri_template).to_return(body: RICH_MENU_ALIAS_LIST_CONTENT, status: 200)

    client.get_rich_menus_alias_list
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/alias/list')
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
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:get, uri_template).to_return(body: File.open(RICH_MENU_IMAGE_FILE_PATH).read, status: 200)

    response = client.get_rich_menu_image('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/richmenu/1234567/content')
    expect(response.body).to eq File.open(RICH_MENU_IMAGE_FILE_PATH).read
  end

  it 'uploads and attaches an image to a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/richmenu/1234567/content'

    stub_request(:post, uri_template).to_return(body: '{}', status: 200).with do |request|
      expect(request.headers["Content-Type"]).to eq('image/png')
    end

    File.open(RICH_MENU_IMAGE_FILE_PATH) do |image_file|
      client.create_rich_menu_image('1234567', image_file)
    end

    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/richmenu/1234567/content')
      .with(body: File.open(RICH_MENU_IMAGE_FILE_PATH).read)
  end

  it 'uploads and attaches an image to a rich menu from uri' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/richmenu/1234567/content'

    stub_request(:post, uri_template).to_return(body: '{}', status: 200).with do |request|
      expect(request.headers["Content-Type"]).to eq('image/png')
    end

    image_url = 'https://line.example.org/rich_menu.png'
    image_content = File.open(RICH_MENU_IMAGE_FILE_PATH).read
    image_content.force_encoding('ASCII-8BIT')
    stub_request(:get, image_url).to_return(body: image_content, status: 200, headers: { 'Content-Type' => 'image/png' })

    client.create_rich_menu_image('1234567', URI.parse(image_url).open)

    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_BLOB_ENDPOINT + '/bot/richmenu/1234567/content')
      .with(body: image_content)
  end

  it "uploads invalid extension's file" do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)
    expect do
      File.open(RICH_MENU_INVALID_FILE_EXTENSION_PATH) do |file|
        client.create_rich_menu_image('1234567', file)
      end
    end.to raise_error(ArgumentError)
  end

  it 'uploads invalid content type uri' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:post, uri_template).to_return(body: '{}', status: 200)

    text_url = 'https://line.example.org/rich_menu.txt'
    text_content = File.open(RICH_MENU_INVALID_FILE_EXTENSION_PATH).read
    stub_request(:get, text_url).to_return(body: text_content, status: 200, headers: { 'Content-Type' => 'plain/text' })

    expect do
      client.create_rich_menu_image('1234567', URI.parse(text_url).open)
    end.to raise_error(ArgumentError)
  end
end
