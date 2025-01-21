require 'spec_helper'
require 'webmock/rspec'
require 'json'

LINK_TOKEN_CONTENT = <<"EOS"
{
  "linkToken":"abcdefg0123456789"
}
EOS

describe Line::Bot::Client do
  let(:client) do
    dummy_config = {
      channel_token: 'access token',
    }
    Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end
  end

  it 'issues a link token' do
    uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/{user_id}/linkToken'
    stub_request(:post, uri_template).to_return(body: LINK_TOKEN_CONTENT, status: 200)

    response = client.create_link_token('user_id')
    expect(WebMock).to have_requested(:post, Line::Bot::API::DEFAULT_ENDPOINT + '/bot/user/user_id/linkToken')
    expect(response.body).to eq LINK_TOKEN_CONTENT
  end
end
