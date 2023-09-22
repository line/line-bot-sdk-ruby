require 'spec_helper'

describe LINE::Client::Webhook do
  let(:body) do
    JSON.generate(
      destination: 'xxxxxxxxxx',
      events: [
        {
          replyToken: 'nHuyWiB7yP5Zw52FIkcQobQuGDXCTA',
          type: 'videoPlayComplete',
          mode: 'active',
          timestamp: 1462629479859,
          source: {
            type: 'user',
            userId: 'U4af4980629...'
          },
          webhookEventId: '01FZ74A0TDDPYRVKNK77XKC3ZR',
          deliveryContext: {
            isRedelivery: false
          },
          videoPlayComplete: {
            trackingId: 'track-id'
          }
        }
      ]
    )
  end
  let(:channel_secret) { 'channel secret' }

  it 'validates a signature with success' do
    result = LINE::Client::Webhook.validate_signature(body, 'moA4ZK/DQvvl3uSUh1tkXnyLDiQa4t17vcieTpAKKls=', channel_secret)
    expect(result).to be_truthy
  end

  it 'validates a signature with failure' do
    result = LINE::Client::Webhook.validate_signature(body, 'invalid signature', channel_secret)
    expect(result).to be_falsey
  end

  it 'parses events from the body' do
    events = LINE::Client::Webhook.parse_events_from(body)
    event = events[0]
    expect(event.class).to eq LINE::Client::Webhook::VideoPlayCompleteEvent
    expect(event.reply_token).to eq 'nHuyWiB7yP5Zw52FIkcQobQuGDXCTA'
  end
end
