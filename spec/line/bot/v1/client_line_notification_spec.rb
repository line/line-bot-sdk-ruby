require 'spec_helper'
require 'webmock/rspec'

DELIVERY_RESULT_CONTENT = <<~"EOS"
{
  "status": "ready",
  "success": 3
}
EOS

describe Line::Bot::Client do
  describe '#push_pnp' do
    before do
      uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + '/bot/pnp/push'
      stub_request(:post, uri_template).to_return { |request| { body: '{}', status: 200 } }
    end

    let(:client)  do
      Line::Bot::Client.new do |config|
        config.channel_token = 'channel_token'
      end
    end
    let(:phone_number) { "+818000001234" }
    let(:hashed_phone_number) { Digest::SHA256.hexdigest(phone_number) }
    let(:x_line_delivery_tag) { 'd41e0ad70dddfeb68f149ad6fc61574b9c5780ab7bcb2fba5517771ffbb2409c' }
    let(:message) do
      {
        type: 'text',
        text: 'Hello, world'
      }
    end

    context 'normal scenario' do
      it 'pushes the message' do
        response = client.push_pnp(hashed_phone_number, message)

        expect(response).to be_a(Net::HTTPOK)
        expect(response.body).to eq('{}')
      end
    end

    context 'with X-Line-Delivery-Tag header' do
      it 'pushes the message with additional header' do
        response = client.push_pnp(hashed_phone_number, message, headers: { 'X-Line-Delivery-Tag' => x_line_delivery_tag })

        expect(response).to be_a(Net::HTTPOK)
        expect(response.body).to eq('{}')
      end
    end
  end

  describe '#get_message_delivery_pnp' do
    before do
      uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/delivery/pnp?date={date}'
      stub_request(:get, uri_template).to_return { |request| { body: DELIVERY_RESULT_CONTENT, status: 200 } }
    end

    let(:client)  do
      Line::Bot::Client.new do |config|
        config.channel_token = 'channel_token'
      end
    end

    it 'gets the delivery result' do
      response = client.get_message_delivery_pnp('20240524')

      expect(response).to be_a(Net::HTTPOK)
      expect(response.body).to eq(DELIVERY_RESULT_CONTENT)
    end
  end
end
