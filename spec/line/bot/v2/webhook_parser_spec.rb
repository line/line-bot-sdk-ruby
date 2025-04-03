require 'spec_helper'

describe Line::Bot::V2::WebhookParser do
  let(:channel_secret) { 'dummy_channel_secret' }
  let(:signature) { 'dummy_signature' }
  let(:parser) { Line::Bot::V2::WebhookParser.new(channel_secret: channel_secret) }

  describe '#parse' do
    before do
      allow(parser).to receive(:verify_signature).and_return(true)
    end

    context 'with a unknown event' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "Uc7472b39e21dab71c2347e02714630d6",
            "events": [
              {
                "type": "hoge",
                "webhookEventId": "01G17EJCGAVV66J5WNA7ZCTF6H",
                "timestamp": 1650591346705,
                "foo": {
                  "bar": "baz"
                },
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook with no error' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Struct)
        expect(event.type).to eq('hoge')
        expect(event.webhook_event_id).to eq('01G17EJCGAVV66J5WNA7ZCTF6H')
        expect(event.timestamp).to eq(1650591346705)
        expect(event.foo).to be_a(Struct)
        expect(event.foo.bar).to eq('baz')
        expect(event.mode).to eq('active')
      end
    end

    context 'with an unknown message type' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "group",
                  "groupId": "Ca56f94637c...",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "444573844083572737",
                  "type": "hoge",
                  "quoteToken": "q3Plxr4AgKd...",
                  "text": "Test Message"
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a text MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('Ca56f94637c...')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Struct)
        expect(event.message.id).to eq('444573844083572737')
        expect(event.message.type).to eq('hoge')
        expect(event.message.quote_token).to eq('q3Plxr4AgKd...')
        expect(event.message.text).to eq('Test Message')
      end
    end

    context 'with empty event (for webhook test)' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": []
          }
        JSON
      end

      it 'parses the webhook with no error' do
        events = parser.parse(webhook, signature)
        expect(events).to be_empty
      end
    end

    context 'with a full text MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "group",
                  "groupId": "Ca56f94637c...",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "444573844083572737",
                  "type": "text",
                  "quoteToken": "q3Plxr4AgKd...",
                  "text": "@All @example Good Morning!! (love)",
                  "emojis": [
                    {
                      "index": 29,
                      "length": 6,
                      "productId": "5ac1bfd5040ab15980c9b435",
                      "emojiId": "001"
                    }
                  ],
                  "mention": {
                    "mentionees": [
                      {
                        "index": 0,
                        "length": 4,
                        "type": "all"
                      },
                      {
                        "index": 5,
                        "length": 8,
                        "userId": "U49585cd0d5...",
                        "type": "user",
                        "isSelf": false
                      }
                    ]
                  }
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a text MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('Ca56f94637c...')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::TextMessageContent)
        expect(event.message.id).to eq('444573844083572737')
        expect(event.message.type).to eq('text')
        expect(event.message.quote_token).to eq('q3Plxr4AgKd...')
        expect(event.message.text).to eq('@All @example Good Morning!! (love)')
        expect(event.message.emojis).to be_a(Array)
        expect(event.message.emojis.first).to be_a(Line::Bot::V2::Webhook::Emoji)
        expect(event.message.emojis.first.index).to eq(29)
        expect(event.message.emojis.first.length).to eq(6)
        expect(event.message.emojis.first.product_id).to eq('5ac1bfd5040ab15980c9b435')
        expect(event.message.emojis.first.emoji_id).to eq('001')
        expect(event.message.mention).to be_a(Line::Bot::V2::Webhook::Mention)
        expect(event.message.mention.mentionees).to be_a(Array)
        expect(event.message.mention.mentionees.first).to be_a(Line::Bot::V2::Webhook::AllMentionee)
        expect(event.message.mention.mentionees.first.index).to eq(0)
        expect(event.message.mention.mentionees.first.index).to eq(0)
        expect(event.message.mention.mentionees.first.length).to eq(4)
        expect(event.message.mention.mentionees.first.type).to eq('all')
        expect(event.message.mention.mentionees.last).to be_a(Line::Bot::V2::Webhook::UserMentionee)
        expect(event.message.mention.mentionees.last.index).to eq(5)
        expect(event.message.mention.mentionees.last.length).to eq(8)
        expect(event.message.mention.mentionees.last.user_id).to eq('U49585cd0d5...')
        expect(event.message.mention.mentionees.last.type).to eq('user')
      end
    end

    context 'with a minimum text MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "444573844083572737",
                  "type": "text",
                  "quoteToken": "q3Plxr4AgKd...",
                  "text": " Hi "
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a text MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::TextMessageContent)
        expect(event.message.id).to eq('444573844083572737')
        expect(event.message.type).to eq('text')
        expect(event.message.quote_token).to eq('q3Plxr4AgKd...')
        expect(event.message.text).to eq(' Hi ')
        expect(event.message.emojis).to be_nil
        expect(event.message.mention).to be_nil
      end
    end

    context 'with two image MessageEvents' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "type": "message",
                "message": {
                  "type": "image",
                  "id": "354718705033693859",
                  "quoteToken": "q3Plxr4AgKd...",
                  "contentProvider": {
                    "type": "line"
                  },
                  "imageSet": {
                    "id": "E005D41A7288F41B65593ED38FF6E9834B046AB36A37921A56BC236F13A91855",
                    "index": 1,
                    "total": 2
                  }
                },
                "timestamp": 1627356924513,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "replyToken": "7840b71058e24a5d91f9b5726c7512c9",
                "mode": "active"
              },
              {
                "type": "message",
                "message": {
                  "type": "image",
                  "id": "354718705033693861",
                  "quoteToken": "yHAz4Ua2wx7...",
                  "contentProvider": {
                    "type": "line"
                  },
                  "imageSet": {
                    "id": "E005D41A7288F41B65593ED38FF6E9834B046AB36A37921A56BC236F13A91855",
                    "index": 2,
                    "total": 2
                  }
                },
                "timestamp": 1627356924722,
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

      it 'parses the webhook as image MessageEvents' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        expect(events[0]).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(events[0].message).to be_a(Line::Bot::V2::Webhook::ImageMessageContent)
        expect(events[0].message.id).to eq('354718705033693859')
        expect(events[0].message.type).to eq('image')
        expect(events[0].message.quote_token).to eq('q3Plxr4AgKd...')
        expect(events[0].message.content_provider).to be_a(Line::Bot::V2::Webhook::ContentProvider)
        expect(events[0].message.content_provider.type).to eq('line')
        expect(events[1].message.image_set).to be_a(Line::Bot::V2::Webhook::ImageSet)
        expect(events[0].message.image_set.id).to eq('E005D41A7288F41B65593ED38FF6E9834B046AB36A37921A56BC236F13A91855')
        expect(events[0].message.image_set.index).to eq(1)
        expect(events[0].message.image_set.total).to eq(2)
        expect(events[0].timestamp).to eq(1627356924513)
        expect(events[0].source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(events[0].source.type).to eq('user')
        expect(events[0].source.user_id).to eq('U4af4980629...')
        expect(events[0].reply_token).to eq('7840b71058e24a5d91f9b5726c7512c9')
        expect(events[0].mode).to eq('active')

        expect(events[1]).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(events[1].message).to be_a(Line::Bot::V2::Webhook::ImageMessageContent)
        expect(events[1].message.id).to eq('354718705033693861')
        expect(events[1].message.type).to eq('image')
        expect(events[1].message.quote_token).to eq('yHAz4Ua2wx7...')
        expect(events[1].message.content_provider).to be_a(Line::Bot::V2::Webhook::ContentProvider)
        expect(events[1].message.content_provider.type).to eq('line')
        expect(events[1].message.image_set).to be_a(Line::Bot::V2::Webhook::ImageSet)
        expect(events[1].message.image_set.id).to eq('E005D41A7288F41B65593ED38FF6E9834B046AB36A37921A56BC236F13A91855')
        expect(events[1].message.image_set.index).to eq(2)
        expect(events[1].message.image_set.total).to eq(2)
        expect(events[1].timestamp).to eq(1627356924722)
        expect(events[1].source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(events[1].source.type).to eq('user')
        expect(events[1].source.user_id).to eq('U4af4980629...')
        expect(events[1].reply_token).to eq('fbf94e269485410da6b7e3a5e33283e8')
        expect(events[1].mode).to eq('active')
      end
    end

    context 'with a video MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "325708",
                  "type": "video",
                  "quoteToken": "q3Plxr4AgKd...",
                  "duration": 60000,
                  "contentProvider": {
                    "type": "external",
                    "originalContentUrl": "https://example.com/original.mp4",
                    "previewImageUrl": "https://example.com/preview.jpg"
                  }
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a video MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::VideoMessageContent)
        expect(event.message.id).to eq('325708')
        expect(event.message.type).to eq('video')
        expect(event.message.quote_token).to eq('q3Plxr4AgKd...')
        expect(event.message.duration).to eq(60000)
        expect(event.message.content_provider).to be_a(Line::Bot::V2::Webhook::ContentProvider)
        expect(event.message.content_provider.type).to eq('external')
        expect(event.message.content_provider.original_content_url).to eq('https://example.com/original.mp4')
        expect(event.message.content_provider.preview_image_url).to eq('https://example.com/preview.jpg')
      end
    end

    context 'with an audio MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "325708",
                  "type": "audio",
                  "duration": 60000,
                  "contentProvider": {
                    "type": "line"
                  }
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as an audio MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::AudioMessageContent)
        expect(event.message.id).to eq('325708')
        expect(event.message.type).to eq('audio')
        expect(event.message.duration).to eq(60000)
        expect(event.message.content_provider).to be_a(Line::Bot::V2::Webhook::ContentProvider)
        expect(event.message.content_provider.type).to eq('line')
      end
    end

    context 'with a file MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "325708",
                  "type": "file",
                  "fileName": "file.txt",
                  "fileSize": 2138
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a file MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::FileMessageContent)
        expect(event.message.id).to eq('325708')
        expect(event.message.type).to eq('file')
        expect(event.message.file_name).to eq('file.txt')
        expect(event.message.file_size).to eq(2138)
      end
    end

    context 'with a location MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "message",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "message": {
                  "id": "325708",
                  "type": "location",
                  "title": "my location",
                  "address": "日本、〒102-8282 東京都千代田区紀尾井町1番3号",
                  "latitude": 35.67966,
                  "longitude": 139.73669
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a location MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::LocationMessageContent)
        expect(event.message.id).to eq('325708')
        expect(event.message.type).to eq('location')
        expect(event.message.title).to eq('my location')
        expect(event.message.address).to eq('日本、〒102-8282 東京都千代田区紀尾井町1番3号')
        expect(event.message.latitude).to eq(35.67966)
        expect(event.message.longitude).to eq(139.73669)
      end
    end

    context 'with an animation sticker MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
              "destination": "xxxxxxxxxx",
              "events": [
                  {
                      "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                      "type": "message",
                      "mode": "active",
                      "timestamp": 1462629479859,
                      "source": {
                          "type": "user",
                          "userId": "U4af4980629..."
                      },
                      "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                      "deliveryContext": {
                          "isRedelivery": false
                      },
                      "message": {
                          "type": "sticker",
                          "id": "1501597916",
                          "quoteToken": "q3Plxr4AgKd...",
                          "stickerId": "52002738",
                          "packageId": "11537",
                          "stickerResourceType": "ANIMATION",
                          "keywords": [
                              "cony",
                              "sally",
                              "Staring",
                              "hi",
                              "whatsup",
                              "line",
                              "howdy",
                              "HEY",
                              "Peeking",
                              "wave",
                              "peek",
                              "Hello",
                              "yo",
                              "greetings"
                          ]
                      }
                  }
              ]
          }
        JSON
      end

      it 'parses the webhook as a sticker MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::StickerMessageContent)
        expect(event.message.id).to eq('1501597916')
        expect(event.message.type).to eq('sticker')
        expect(event.message.quote_token).to eq('q3Plxr4AgKd...')
        expect(event.message.sticker_id).to eq('52002738')
        expect(event.message.package_id).to eq('11537')
        expect(event.message.sticker_resource_type).to eq('ANIMATION')
        expect(event.message.keywords).to eq(["cony", "sally", "Staring", "hi", "whatsup", "line", "howdy", "HEY", "Peeking", "wave", "peek", "Hello", "yo", "greetings"])
      end
    end

    context 'with a sticker MessageEvent' do
      let(:webhook) do
        <<~JSON
          {
              "destination": "xxxxxxxxxx",
              "events": [
                  {
                      "type": "message",
                      "message": {
                          "type": "sticker",
                          "id": "123456789012345678",
                          "quoteToken": "q3Plxr4AgKd...",
                          "stickerId": "738839",
                          "packageId": "12287",
                          "stickerResourceType": "MESSAGE",
                          "keywords": [
                              "Anticipation",
                              "Sparkle",
                              "Straight face",
                              "Staring",
                              "Thinking"
                          ],
                          "text": "今週末\\n一緒に\\n遊ぼうよ！"
                      },
                      "timestamp": 1635756190879,
                      "source": {
                          "type": "group",
                          "groupId": "C99ae82bcd...",
                          "userId": "Ub82c8fd9b..."
                      },
                      "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                      "deliveryContext": {
                          "isRedelivery": false
                      },
                      "replyToken": "ce8c57ec18374a4b94f40abab97145f8",
                      "mode": "active"
                  }
              ]
          }
        JSON
      end

      it 'parses the webhook as a sticker MessageEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MessageEvent)
        expect(event.reply_token).to eq('ce8c57ec18374a4b94f40abab97145f8')
        expect(event.type).to eq('message')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1635756190879)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('C99ae82bcd...')
        expect(event.source.user_id).to eq('Ub82c8fd9b...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.message).to be_a(Line::Bot::V2::Webhook::StickerMessageContent)
        expect(event.message.id).to eq('123456789012345678')
        expect(event.message.type).to eq('sticker')
        expect(event.message.quote_token).to eq('q3Plxr4AgKd...')
        expect(event.message.sticker_id).to eq('738839')
        expect(event.message.package_id).to eq('12287')
        expect(event.message.sticker_resource_type).to eq('MESSAGE')
        expect(event.message.text).to eq("今週末\n一緒に\n遊ぼうよ！")
        expect(event.message.keywords).to eq(["Anticipation", "Sparkle", "Straight face", "Staring", "Thinking"])
      end
    end

    context 'with an UnsendEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "type": "unsend",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "group",
                  "groupId": "Ca56f94637c...",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "unsend": {
                  "messageId": "325708"
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as an UnsendEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::UnsendEvent)
        expect(event.type).to eq('unsend')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('Ca56f94637c...')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.unsend).to be_a(Line::Bot::V2::Webhook::UnsendDetail)
        expect(event.unsend.message_id).to eq('325708')
      end
    end

    context 'with a simple FollowEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "85cbe770fa8b4f45bbe077b1d4be4a36",
                "type": "follow",
                "mode": "active",
                "timestamp": 1705891467176,
                "source": {
                  "type": "user",
                  "userId": "U3d3edab4f36c6292e6d8a8131f141b8b"
                },
                "webhookEventId": "01HMQGW40RZJPJM3RAJP7BHC2Q",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "follow": {
                  "isUnblocked": false
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a FollowEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::FollowEvent)
        expect(event.type).to eq('follow')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1705891467176)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U3d3edab4f36c6292e6d8a8131f141b8b')
        expect(event.webhook_event_id).to eq('01HMQGW40RZJPJM3RAJP7BHC2Q')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.follow).to be_a(Line::Bot::V2::Webhook::FollowDetail)
        expect(event.follow.is_unblocked).to be false
      end
    end

    context 'with an unblocked FollowEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "follow",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "follow": {
                  "isUnblocked": true
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a FollowEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::FollowEvent)
        expect(event.type).to eq('follow')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.follow).to be_a(Line::Bot::V2::Webhook::FollowDetail)
        expect(event.follow.is_unblocked).to be true
      end
    end

    context 'with an UnfollowEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "type": "unfollow",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a UnfollowEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::UnfollowEvent)
        expect(event.type).to eq('unfollow')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
      end
    end

    context 'with a JoinEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "join",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "group",
                  "groupId": "C4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a JoinEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::JoinEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('join')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('C4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
      end
    end

    context 'with a LeaveEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "type": "leave",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "group",
                  "groupId": "C4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a LeaveEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::LeaveEvent)
        expect(event.type).to eq('leave')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('C4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
      end
    end

    context 'with a MemberJoinedEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "0f3779fba3b349968c5d07db31eabf65",
                "type": "memberJoined",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "group",
                  "groupId": "C4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "joined": {
                  "members": [
                    {
                      "type": "user",
                      "userId": "U4af4980629..."
                    },
                    {
                      "type": "user",
                      "userId": "U91eeaf62d9..."
                    }
                  ]
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a MemberJoinedEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MemberJoinedEvent)
        expect(event.type).to eq('memberJoined')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('C4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.joined).to be_a(Line::Bot::V2::Webhook::JoinedMembers)
        expect(event.joined.members).to be_an(Array)
        expect(event.joined.members.size).to eq(2)
        expect(event.joined.members[0]).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.joined.members[0].type).to eq('user')
        expect(event.joined.members[0].user_id).to eq('U4af4980629...')
        expect(event.joined.members[1]).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.joined.members[1].type).to eq('user')
        expect(event.joined.members[1].user_id).to eq('U91eeaf62d9...')
      end
    end

    context 'with a MemberLetfEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "type": "memberLeft",
                "mode": "active",
                "timestamp": 1462629479960,
                "source": {
                  "type": "group",
                  "groupId": "C4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "left": {
                  "members": [
                    {
                      "type": "user",
                      "userId": "U4af4980629..."
                    },
                    {
                      "type": "user",
                      "userId": "U91eeaf62d9..."
                    }
                  ]
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a MemberLeftEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::MemberLeftEvent)
        expect(event.type).to eq('memberLeft')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479960)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::GroupSource)
        expect(event.source.type).to eq('group')
        expect(event.source.group_id).to eq('C4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.left).to be_a(Line::Bot::V2::Webhook::LeftMembers)
        expect(event.left.members).to be_an(Array)
        expect(event.left.members.size).to eq(2)
        expect(event.left.members[0]).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.left.members[0].type).to eq('user')
        expect(event.left.members[0].user_id).to eq('U4af4980629...')
        expect(event.left.members[1]).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.left.members[1].type).to eq('user')
        expect(event.left.members[1].user_id).to eq('U91eeaf62d9...')
      end
    end

    context 'with a time selected PostbackEvent' do
      let(:webhook) do
        <<~JSON
          {
              "destination": "xxxxxxxxxx",
              "events": [
                  {
                      "replyToken": "b60d432864f44d079f6d8efe86cf404b",
                      "type": "postback",
                      "mode": "active",
                      "source": {
                          "userId": "U91eeaf62d...",
                          "type": "user"
                      },
                      "timestamp": 1513669370317,
                      "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                      "deliveryContext": {
                          "isRedelivery": false
                      },
                      "postback": {
                          "data": "storeId=12345",
                          "params": {
                              "datetime": "2017-12-25T01:00"
                          }
                      }
                  }
              ]
          }
        JSON
      end

      it 'parses the webhook as a PostbackEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::PostbackEvent)
        expect(event.type).to eq('postback')
        expect(event.mode).to eq('active')
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U91eeaf62d...')
        expect(event.timestamp).to eq(1513669370317)
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.postback).to be_a(Line::Bot::V2::Webhook::PostbackContent)
        expect(event.postback.data).to eq('storeId=12345')
        expect(event.postback.params).to be_a(Struct)
        expect(event.postback.params.datetime).to eq('2017-12-25T01:00')
      end
    end

    context 'with a rich menu selected PostbackEvent' do
      let(:webhook) do
        <<~JSON
          {
              "destination": "xxxxxxxxxx",
              "events": [
                  {
                      "replyToken": "b60d432864f44d079f6d8efe86cf404b",
                      "type": "postback",
                      "mode": "active",
                      "source": {
                          "userId": "U91eeaf62d...",
                          "type": "user"
                      },
                      "timestamp": 1619754620404,
                      "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                      "deliveryContext": {
                          "isRedelivery": false
                      },
                      "postback": {
                          "data": "richmenu-changed-to-b",
                          "params": {
                              "newRichMenuAliasId": "richmenu-alias-b",
                              "status": "SUCCESS"
                          }
                      }
                  }
              ]
          }
        JSON
      end

      it 'parses the webhook as a PostbackEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::PostbackEvent)
        expect(event.type).to eq('postback')
        expect(event.mode).to eq('active')
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U91eeaf62d...')
        expect(event.timestamp).to eq(1619754620404)
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.postback).to be_a(Line::Bot::V2::Webhook::PostbackContent)
        expect(event.postback.data).to eq('richmenu-changed-to-b')
        expect(event.postback.params).to be_a(Struct)
        expect(event.postback.params.new_rich_menu_alias_id).to eq('richmenu-alias-b')
        expect(event.postback.params.status).to eq('SUCCESS')
      end
    end

    context 'with a VideoPlayComplete' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "videoPlayComplete",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "videoPlayComplete": {
                  "trackingId": "track-id"
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a VideoPlayComplete' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::VideoPlayCompleteEvent)
        expect(event.type).to eq('videoPlayComplete')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.video_play_complete).to be_a(Line::Bot::V2::Webhook::VideoPlayComplete)
        expect(event.video_play_complete.tracking_id).to eq('track-id')
      end
    end

    context 'with a BeaconEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "type": "beacon",
                "mode": "active",
                "timestamp": 1462629479859,
                "source": {
                  "type": "user",
                  "userId": "U4af4980629..."
                },
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "beacon": {
                  "hwid": "d41d8cd98f",
                  "type": "enter"
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a BeaconEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::BeaconEvent)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.type).to eq('beacon')
        expect(event.mode).to eq('active')
        expect(event.timestamp).to eq(1462629479859)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U4af4980629...')
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.beacon).to be_a(Line::Bot::V2::Webhook::BeaconContent)
        expect(event.beacon.hwid).to eq('d41d8cd98f')
        expect(event.beacon.type).to eq('enter')
      end
    end

    context 'with a AccountLinkEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "xxxxxxxxxx",
            "events": [
              {
                "replyToken": "b60d432864f44d079f6d8efe86cf404b",
                "type": "accountLink",
                "mode": "active",
                "source": {
                  "userId": "U91eeaf62d...",
                  "type": "user"
                },
                "timestamp": 1513669370317,
                "webhookEventId": "01FZ74A0TDDPYRVKNK77XKC3ZR",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "link": {
                  "result": "ok",
                  "nonce": "xxxxxxxxxxxxxxx"
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a AccountLinkEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::AccountLinkEvent)
        expect(event.reply_token).to eq('b60d432864f44d079f6d8efe86cf404b')
        expect(event.type).to eq('accountLink')
        expect(event.mode).to eq('active')
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U91eeaf62d...')
        expect(event.timestamp).to eq(1513669370317)
        expect(event.webhook_event_id).to eq('01FZ74A0TDDPYRVKNK77XKC3ZR')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.link).to be_a(Line::Bot::V2::Webhook::LinkContent)
        expect(event.link.result).to eq('ok')
        expect(event.link.nonce).to eq('xxxxxxxxxxxxxxx')
      end
    end

    context 'with a attached ModuleEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "U53387d54817...",
            "events": [
              {
                "type": "module",
                "module": {
                  "type": "attached",
                  "botId": "U53387d54817...",
                  "scopes": [
                    "message:send",
                    "message:receive"
                  ]
                },
                "webhookEventId": "01G3GCEEXNWREGSSFVTPYH8465",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1653038594997,
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a ModuleEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::ModuleEvent)
        expect(event.type).to eq('module')
        expect(event._module).to be_a(Line::Bot::V2::Webhook::AttachedModuleContent)
        expect(event._module.type).to eq('attached')
        expect(event._module.bot_id).to eq('U53387d54817...')
        expect(event._module.scopes).to eq(["message:send", "message:receive"])
        expect(event.webhook_event_id).to eq('01G3GCEEXNWREGSSFVTPYH8465')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1653038594997)
        expect(event.mode).to eq('active')
      end
    end

    context 'with a detached ModuleEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "U5fac33f633e72c192759f09afc41fa28",
            "events": [
              {
                "type": "module",
                "module": {
                  "type": "detached",
                  "botId": "U5fac33f633e72c192759f09afc41fa28",
                  "reason": "bot_deleted"
                },
                "webhookEventId": "01G4CPSV08QGNT1DWFC4DSWDNP",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1653988977672,
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a ModuleEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::ModuleEvent)
        expect(event.type).to eq('module')
        expect(event._module).to be_a(Line::Bot::V2::Webhook::DetachedModuleContent)
        expect(event._module.type).to eq('detached')
        expect(event._module.bot_id).to eq('U5fac33f633e72c192759f09afc41fa28')
        expect(event.webhook_event_id).to eq('01G4CPSV08QGNT1DWFC4DSWDNP')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1653988977672)
        expect(event.mode).to eq('active')
      end
    end

    context 'with a ActivatedEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "U5fac33f633e72c192759f09afc41fa28",
            "events": [
              {
                "type": "activated",
                "chatControl": {
                  "expireAt": 1653994422933
                },
                "webhookEventId": "01G4CRJ54J7TT4WN190KKHBXXT",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1653990823058,
                "source": {
                  "type": "user",
                  "userId": "LUb577ef3cbe..."
                },
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a ActivatedEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::ActivatedEvent)
        expect(event.type).to eq('activated')
        expect(event.chat_control).to be_a(Line::Bot::V2::Webhook::ChatControl)
        expect(event.chat_control.expire_at).to eq(1653994422933)
        expect(event.webhook_event_id).to eq('01G4CRJ54J7TT4WN190KKHBXXT')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1653990823058)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('LUb577ef3cbe...')
        expect(event.mode).to eq('active')
      end
    end

    context 'with a DeactivatedEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "U5fac33f633e72c192759f09afc41fa28",
            "events": [
              {
                "type": "deactivated",
                "webhookEventId": "01G4CRJ51100K1D1791KC9J4G4",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1653990822945,
                "source": {
                  "type": "user",
                  "userId": "LUb577ef3cbe..."
                },
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a DeactivatedEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::DeactivatedEvent)
        expect(event.type).to eq('deactivated')
        expect(event.webhook_event_id).to eq('01G4CRJ51100K1D1791KC9J4G4')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1653990822945)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('LUb577ef3cbe...')
        expect(event.mode).to eq('active')
      end
    end

    context 'with a BotSuspendedEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "U53387d548170020e6cedef5f41d1e01d",
            "events": [
              {
                "type": "botSuspended",
                "webhookEventId": "01G4CRJ54J7TT4WN190KKHBXXT",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1616390574119,
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a BotSuspensionEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::BotSuspendedEvent)
        expect(event.type).to eq('botSuspended')
        expect(event.webhook_event_id).to eq('01G4CRJ54J7TT4WN190KKHBXXT')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1616390574119)
        expect(event.mode).to eq('active')
      end
    end

    context 'with a BotResumedEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "U5fac33f633e72c192759f09afc41fa28",
            "events": [
              {
                "type": "botResumed",
                "webhookEventId": "01G4CS8T91R1V1JCE0G43DQND8",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1653991565601,
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a BotResumedEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::BotResumedEvent)
        expect(event.type).to eq('botResumed')
        expect(event.webhook_event_id).to eq('01G4CS8T91R1V1JCE0G43DQND8')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1653991565601)
        expect(event.mode).to eq('active')
      end
    end

    context 'with a PnpDeliveryCompletionEvent without X-Line-Delivery-Tag' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "Uc7472b39e21dab71c2347e02714630d6",
            "events": [
              {
                "type": "delivery",
                "delivery": {
                  "data": "68df277462529930889fab80ecffdc0883906320591df93c25efc08300410fc2"
                },
                "webhookEventId": "01G17DAF0QJ7A3ERC5EJ9MAMH8",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1650590038721,
                "source": {
                  "type": "user",
                  "userId": "U8189cf6745fc0d808977bdb0b9f22995"
                },
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a PnpDeliveryCompletionEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::PnpDeliveryCompletionEvent)
        expect(event.type).to eq('delivery')
        expect(event.delivery).to be_a(Line::Bot::V2::Webhook::PnpDelivery)
        expect(event.delivery.data).to eq('68df277462529930889fab80ecffdc0883906320591df93c25efc08300410fc2')
        expect(event.webhook_event_id).to eq('01G17DAF0QJ7A3ERC5EJ9MAMH8')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1650590038721)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U8189cf6745fc0d808977bdb0b9f22995')
        expect(event.mode).to eq('active')
      end
    end

    context 'with a PnpDeliveryCompletionEvent with X-Line-Delivery-Tag' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "Uc7472b39e21dab71c2347e02714630d6",
            "events": [
              {
                "type": "delivery",
                "delivery": {
                  "data": "15034552939884E28681A7D668CEA94C147C716C0EC9DFE8B80B44EF3B57F6BD0602366BC3menu01"
                },
                "webhookEventId": "01G17EJCGAVV66J5WNA7ZCTF6H",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "timestamp": 1650591346705,
                "source": {
                  "type": "user",
                  "userId": "U8189cf6745fc0d808977bdb0b9f22995"
                },
                "mode": "active"
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a PnpDeliveryCompletionEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::PnpDeliveryCompletionEvent)
        expect(event.type).to eq('delivery')
        expect(event.delivery).to be_a(Line::Bot::V2::Webhook::PnpDelivery)
        expect(event.delivery.data).to eq('15034552939884E28681A7D668CEA94C147C716C0EC9DFE8B80B44EF3B57F6BD0602366BC3menu01')
        expect(event.webhook_event_id).to eq('01G17EJCGAVV66J5WNA7ZCTF6H')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.timestamp).to eq(1650591346705)
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U8189cf6745fc0d808977bdb0b9f22995')
        expect(event.mode).to eq('active')
      end
    end

    context 'with a ThingsEvent' do
      let(:webhook) do
        <<~JSON
          {
            "destination": "Uc7472b39e21dab71c2347e02714630d6",
            "events": [
              {
                "type": "things",
                "timestamp": 1650591346705,
                "replyToken": "nHuyWiB7yP5Zw52FIkcQobQuGDXCTA",
                "source": {
                  "type": "user",
                  "userId": "U8189cf6745fc0d808977bdb0b9f22995"
                },
                "webhookEventId": "01G17EJCGAVV66J5WNA7ZCTF6H",
                "deliveryContext": {
                  "isRedelivery": false
                },
                "mode": "active",
                "things": {
                  "type": "scenarioResult",
                  "deviceId": "xxxxxxxxxxxxxxxxxxx",
                  "result": {
                    "scenarioId": "xxxxxxxxxxxxxxx",
                    "revision": 0,
                    "resultCode": "success",
                    "startTime": 1650591345705,
                    "endTime": 1650591346605,
                    "bleNotificationPayload": "xxxxxxx",
                    "actionResults": [
                      {
                        "data": "xxxxxxx",
                        "type": "binary"
                      },
                      {
                        "type": "void"
                      },
                      {
                        "type": "void"
                      }
                    ]
                  }
                }
              }
            ]
          }
        JSON
      end

      it 'parses the webhook as a ThingsEvent' do
        events = parser.parse(webhook, signature)
        expect(events).not_to be_empty

        event = events.first
        expect(event).to be_a(Line::Bot::V2::Webhook::ThingsEvent)
        expect(event.type).to eq('things')
        expect(event.timestamp).to eq(1650591346705)
        expect(event.reply_token).to eq('nHuyWiB7yP5Zw52FIkcQobQuGDXCTA')
        expect(event.source).to be_a(Line::Bot::V2::Webhook::UserSource)
        expect(event.source.type).to eq('user')
        expect(event.source.user_id).to eq('U8189cf6745fc0d808977bdb0b9f22995')
        expect(event.webhook_event_id).to eq('01G17EJCGAVV66J5WNA7ZCTF6H')
        expect(event.delivery_context).to be_a(Line::Bot::V2::Webhook::DeliveryContext)
        expect(event.delivery_context.is_redelivery).to be false
        expect(event.mode).to eq('active')
        expect(event.things).to be_a(Line::Bot::V2::Webhook::ScenarioResultThingsContent)
        expect(event.things.type).to eq('scenarioResult')
        expect(event.things.device_id).to eq('xxxxxxxxxxxxxxxxxxx')
        expect(event.things.result).to be_a(Line::Bot::V2::Webhook::ScenarioResult)
        expect(event.things.result.scenario_id).to eq('xxxxxxxxxxxxxxx')
        expect(event.things.result.revision).to eq(0)
        expect(event.things.result.result_code).to eq('success')
        expect(event.things.result.start_time).to eq(1650591345705)
        expect(event.things.result.end_time).to eq(1650591346605)
        expect(event.things.result.ble_notification_payload).to eq('xxxxxxx')
        expect(event.things.result.action_results).to be_an(Array)
        expect(event.things.result.action_results.size).to eq(3)
        expect(event.things.result.action_results[0].data).to eq('xxxxxxx')
        expect(event.things.result.action_results[0].type).to eq('binary')
        expect(event.things.result.action_results[1].type).to eq('void')
        expect(event.things.result.action_results[2].type).to eq('void')
      end
    end
  end
end
