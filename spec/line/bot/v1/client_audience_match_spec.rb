require 'spec_helper'
require 'webmock/rspec'

DELIVERY_RESULT_CONTENT = <<~"EOS"
{
  "status": "ready",
  "success": 10000
}
EOS

describe Line::Bot::Client do
  describe '#multicast_by_phone_numbers' do
    before do
      uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_OAUTH_ENDPOINT + 'bot/ad/multicast/phone'
      stub_request(:post, uri_template).to_return { |request| { body: '{}', status: 200 } }
    end

    let(:client)  do
      Line::Bot::Client.new do |config|
        config.channel_token = 'channel_token'
      end
    end
    let(:phone_numbers) { ['818000000000', '817000000000'].map { Digest::SHA256.hexdigest(_1) } }
    let(:message) do
      {
        type: 'text',
        text: 'Hello, world'
      }
    end

    context 'normal scenario' do
      it 'pushes the message' do
        response = client.multicast_by_phone_numbers(phone_numbers, message)

        expect(response).to be_a(Net::HTTPOK)
        expect(response.body).to eq('{}')
      end
    end

    context 'with additional payload' do
      it 'pushes the message' do
        response = client.multicast_by_phone_numbers(phone_numbers, message, payload: { notificationDisabled: true })

        expect(response).to be_a(Net::HTTPOK)
        expect(response.body).to eq('{}')
      end
    end
  end

  describe '#get_delivery_result_sent_by_phone_numbers' do
    before do
      uri_template = Addressable::Template.new Line::Bot::API::DEFAULT_ENDPOINT + '/bot/message/delivery/ad_phone?date={date}'
      stub_request(:get, uri_template).to_return { |request| { body: DELIVERY_RESULT_CONTENT, status: 200 } }
    end

    let(:client)  do
      Line::Bot::Client.new do |config|
        config.channel_token = 'channel_token'
      end
    end

    it 'gets the delivery result' do
      response = client.get_delivery_result_sent_by_phone_numbers('20230101')

      expect(response).to be_a(Net::HTTPOK)
      expect(response.body).to eq(DELIVERY_RESULT_CONTENT)
    end
  end
end
