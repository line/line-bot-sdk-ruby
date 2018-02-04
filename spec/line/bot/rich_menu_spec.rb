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
    stub_request(:get, uri_template).to_return { |request| { :body => RICH_MENU_LIST_CONTENT, :status => 200 } }

    client.get_rich_menus
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/list')
  end

  it 'gets a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567'
    stub_request(:get, uri_template).to_return { |request| { :body => RICH_MENU_CONTENT, :status => 200 } }

    client.get_rich_menu('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567')
  end

  it 'creates a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu'
    stub_request(:post, uri_template).to_return { |request| { :body => RICH_MENU_CONTENT, :status => 200 } }

    client.create_rich_menu(JSON.parse(RICH_MENU_CONTENT))
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu')
                         .with(:body => JSON.parse(RICH_MENU_CONTENT).to_json)
  end

  it 'deletes a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567'
    stub_request(:delete, uri_template).to_return { |request| { :body => '{}', :status => 200 } }

    client.delete_rich_menu('1234567')
    expect(WebMock).to have_requested(:delete, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567')
  end

  it 'gets rich menu linked to a user' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu'
    stub_request(:get, uri_template).to_return { |request| { :body => '{"richMenuId":"7654321"}', :status => 200 } }

    client.get_user_rich_menu('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu')
  end

  it 'links a rich menu to a user' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu/7654321'
    stub_request(:post, uri_template).to_return { |request| { :body => '{}', :status => 200 } }

    client.link_user_rich_menu('1234567', '7654321')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu/7654321')
  end

  it 'unlinks a rich menu from a user' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu'
    stub_request(:delete, uri_template).to_return { |request| { :body => '{}', :status => 200 } }

    client.unlink_user_rich_menu('1234567')
    expect(WebMock).to have_requested(:delete, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/1234567/richmenu')
  end

  it 'gets an image associated with a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:get, uri_template).to_return { |request| { :body => '', :status => 200 } }

    client.get_rich_menu_image('1234567')
    expect(WebMock).to have_requested(:get, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content')
  end

  it 'uploads and attaches an image to a rich menu' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content'
    stub_request(:post, uri_template).to_return { |request| { :body => '{}', :status => 200 } }

    file_path = 'spec/fixtures/line/bot/rich_menu_01.png'

    client.create_rich_menu_image('1234567', open(file_path))
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/richmenu/1234567/content')
                         .with(:body => open(file_path).read)
  end
end
