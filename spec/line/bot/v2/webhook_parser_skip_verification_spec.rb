require 'spec_helper'

describe Line::Bot::V2::WebhookParser do
  let(:channel_secret) { 'dummy_channel_secret' }
  let(:signature) { 'invalid_signature' }
  let(:webhook) do
    <<~JSON
      {
        "destination": "xxxxxxxxxx",
        "events": [
          {
            "type": "message",
            "message": {
              "type": "text",
              "id": "123456789",
              "quoteToken": "q3Plxr4AgKd...",
              "text": "Hello, world"
            },
            "timestamp": 1462629479859,
            "source": {
              "type": "user",
              "userId": "U4af4980629..."
            },
            "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
            "deliveryContext": {
              "isRedelivery": false
            },
            "replyToken": "fbf94e269485410da6b7e3a5e33283e8",
            "mode": "active"
          }
        ]
      }
    JSON
  end

  describe '#parse with skip_signature_verification' do
    context 'when skip_signature_verification is not provided' do
      let(:parser) { Line::Bot::V2::WebhookParser.new(channel_secret: channel_secret) }

      it 'verifies the signature' do
        expect(parser).to receive(:verify_signature).and_return(false)
        expect { parser.parse(body: webhook, signature: signature) }.to raise_error(Line::Bot::V2::WebhookParser::InvalidSignatureError)
      end
    end

    context 'when skip_signature_verification returns false' do
      let(:parser) { Line::Bot::V2::WebhookParser.new(channel_secret: channel_secret, skip_signature_verification: -> { false }) }

      it 'verifies the signature' do
        expect(parser).to receive(:verify_signature).and_return(false)
        expect { parser.parse(body: webhook, signature: signature) }.to raise_error(Line::Bot::V2::WebhookParser::InvalidSignatureError)
      end
    end

    context 'when skip_signature_verification returns true' do
      let(:parser) { Line::Bot::V2::WebhookParser.new(channel_secret: channel_secret, skip_signature_verification: -> { true }) }

      it 'skips signature verification and parses the webhook' do
        expect(parser).not_to receive(:verify_signature)
        events = parser.parse(body: webhook, signature: signature)
        expect(events).not_to be_empty
        expect(events.first).to be_a(Line::Bot::V2::Webhook::MessageEvent)
      end
    end

    context 'when skip_signature_verification is nil' do
      let(:parser) { Line::Bot::V2::WebhookParser.new(channel_secret: channel_secret, skip_signature_verification: nil) }

      it 'verifies the signature' do
        expect(parser).to receive(:verify_signature).and_return(false)
        expect { parser.parse(body: webhook, signature: signature) }.to raise_error(Line::Bot::V2::WebhookParser::InvalidSignatureError)
      end
    end
  end
end
