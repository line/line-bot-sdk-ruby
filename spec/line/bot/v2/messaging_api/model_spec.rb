require 'spec_helper'

describe 'MessagingApi models' do
  describe 'Line::Bot::V2::MessagingApi::TemplateMessage#initialize' do
    it "contains fixed type attribute" do
      template_message = Line::Bot::V2::MessagingApi::TemplateMessage.new(
        alt_text: 'Test Alt Text',
        template: Line::Bot::V2::MessagingApi::ButtonsTemplate.new(
          text: 'Test Text',
          actions: [],
          title: 'Test Title'
        )
      )

      expect(template_message.type).to eq('template')
    end
  end

  describe 'Line::Bot::V2::MessagingApi::DatetimePickerAction#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates DatetimePickerAction with minimal required fields and broadcasts correctly' do
      text_message = Line::Bot::V2::MessagingApi::TextMessage.new(
        text: "Please pick a date/time!",
        quick_reply: Line::Bot::V2::MessagingApi::QuickReply.new(
          items: [
            Line::Bot::V2::MessagingApi::QuickReplyItem.new(
              action: Line::Bot::V2::MessagingApi::DatetimePickerAction.new(
                data: 'some_data',
                mode: 'datetime',
                label: 'Pick'
              )
            )
          ]
        )
      )

      expected_body = {
        messages: [
          {
            type: 'text',
            text: "Please pick a date/time!",
            quickReply: {
              items: [
                {
                  type: 'action',
                  action: {
                    type: 'datetimepicker', # important: this is the fixed type
                    data: 'some_data',
                    mode: 'datetime',
                    label: 'Pick'
                  }
                }
              ]
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [text_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::RichMenuSwitchAction#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates RichMenuSwitchAction with minimal required fields and broadcasts correctly' do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: "Switch RichMenu",
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexButton.new(
                action: Line::Bot::V2::MessagingApi::RichMenuSwitchAction.new(
                  data: 'switch_richmenu',
                  rich_menu_alias_id: 'alias_xxx',
                  label: 'Switch Menu'
                )
              )
            ]
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Switch RichMenu',
            contents: {
              type: 'bubble',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'button',
                    action: {
                      type: 'richmenuswitch', # important: this is the fixed type
                      data: 'switch_richmenu',
                      richMenuAliasId: 'alias_xxx',
                      label: 'Switch Menu'
                    }
                  }
                ]
              }
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::ImageCarouselTemplate#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates ImageCarouselTemplate with minimal required fields and broadcasts correctly' do
      template_message = Line::Bot::V2::MessagingApi::TemplateMessage.new(
        alt_text: "This is an Image Carousel",
        template: Line::Bot::V2::MessagingApi::ImageCarouselTemplate.new(
          columns: [
            Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
              image_url: 'https://example.com/image1.png',
              action: Line::Bot::V2::MessagingApi::URIAction.new(
                uri: 'https://example.com',
                label: 'Go'
              )
            ),
            Line::Bot::V2::MessagingApi::ImageCarouselColumn.new(
              image_url: 'https://example.com/image2.png',
              action: Line::Bot::V2::MessagingApi::MessageAction.new(
                text: 'Hello!',
                label: 'Say Hello'
              )
            )
          ]
        )
      )

      expected_body = {
        messages: [
          {
            type: 'template',
            altText: 'This is an Image Carousel',
            template: {
              type: 'image_carousel', # important: this is the fixed type
              columns: [
                {
                  imageUrl: 'https://example.com/image1.png',
                  action: {
                    type: 'uri',
                    uri: 'https://example.com',
                    label: 'Go'
                  }
                },
                {
                  imageUrl: 'https://example.com/image2.png',
                  action: {
                    type: 'message',
                    text: 'Hello!',
                    label: 'Say Hello'
                  }
                }
              ]
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [template_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::FlexBoxLinearGradient#initialize' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it 'creates FlexBox with linearGradient background and broadcasts correctly' do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: 'Test FlexBox with LinearGradient',
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexText.new(text: 'Hello World!')
            ],
            background: Line::Bot::V2::MessagingApi::FlexBoxLinearGradient.new(
              angle: '90deg',
              start_color: '#FF0000',
              end_color: '#0000FF'
            )
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Test FlexBox with LinearGradient',
            contents: {
              type: 'bubble',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'text',
                    text: 'Hello World!'
                  }
                ],
                background: {
                  type: 'linearGradient', # important: this is the fixed type
                  angle: '90deg',
                  startColor: '#FF0000',
                  endColor: '#0000FF'
                }
              }
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(
        broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message])
      )
    end
  end

  describe 'Line::Bot::V2::MessagingApi::FlexMessage#initialize - simple flex text' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it "contains fixed type attribute (check in request body), and optional fields don't require input on initialize" do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: 'Test Alt Text',
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new( # FlexBubble has many optional fields
          direction: 'ltr',
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexText.new(
                text: 'Test Text',
                weight: 'bold'
              )
            ]
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Test Alt Text',
            contents: {
              type: 'bubble',
              direction: 'ltr',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'text',
                    text: 'Test Text',
                    weight: 'bold'
                  }
                ]
              }
            }
          }
        ],
        notificationDisabled: false
      }.to_json

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: expected_body
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message]))
    end
  end

  describe 'Line::Bot::V2::MessagingApi::FlexMessage#initialize - do not drop empty array' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }

    it "contains fixed type attribute (check in request body), and optional fields don't require input on initialize" do
      flex_message = Line::Bot::V2::MessagingApi::FlexMessage.new(
        alt_text: 'Test Alt Text',
        contents: Line::Bot::V2::MessagingApi::FlexBubble.new( # FlexBubble has many optional fields
          body: Line::Bot::V2::MessagingApi::FlexBox.new(
            layout: 'vertical',
            contents: [
              Line::Bot::V2::MessagingApi::FlexText.new(
                text: 'Test Text',
                weight: 'bold'
              ),
              Line::Bot::V2::MessagingApi::FlexImage.new(
                url: 'https://example.com/flex/images/image.jpg'
              ),
              Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [], # important: We must send this empty array, because Messaging API requires it
                width: '30px',
                height: '30px',
                background: Line::Bot::V2::MessagingApi::FlexBoxLinearGradient.new(
                  angle: '90deg',
                  start_color: '#FFFF00',
                  end_color: '#0080ff'
                )
              )
            ]
          )
        )
      )

      expected_body = {
        messages: [
          {
            type: 'flex',
            altText: 'Test Alt Text',
            contents: {
              type: 'bubble',
              body: {
                type: 'box',
                layout: 'vertical',
                contents: [
                  {
                    type: 'text',
                    text: 'Test Text',
                    weight: 'bold'
                  },
                  {
                    "type": "image",
                    "url": "https://example.com/flex/images/image.jpg",
                    "size": "md",
                    "animated": false
                  },
                  {
                    "type": "box",
                    "layout": "vertical",
                    "contents": [],
                    "width": "30px",
                    "height": "30px",
                    "background": {
                      "type": "linearGradient",
                      "angle": "90deg",
                      "startColor": "#FFFF00",
                      "endColor": "#0080ff"
                    }
                  }
                ]
              }
            }
          }
        ],
        notificationDisabled: false
      }

      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: 200, body: "{}", headers: { 'Content-Type' => 'application/json' })

      client.broadcast_with_http_info(broadcast_request: Line::Bot::V2::MessagingApi::BroadcastRequest.new(messages: [flex_message]))
    end
  end

  describe '#==' do
    context 'with simple objects' do
      context 'with other class (but same origin)' do
        it 'returns false' do
          obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
          obj2 = Line::Bot::V2::MessagingApi::TextMessageV2.new(text: 'Hello')
          expect(obj1 == obj2).to be false
        end
      end

      context 'with same class' do
        context 'with same attributes' do
          it 'returns true' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            expect(obj1 == obj2).to be true
          end
        end

        context 'with different attributes' do
          it 'returns false' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'World')
            expect(obj1 == obj2).to be false
          end
        end
      end
    end

    context 'with nested objects' do
      context 'with same attributes' do
        it 'returns true' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          expect(obj1 == obj2).to be true
        end
      end

      context 'with different attributes' do
        it 'returns false' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Different Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'horizontal',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Different Text') # diff
                ]
              )
            )
          )
          expect(obj1 == obj2).to be false
        end
      end
    end
  end

  describe '#hash' do
    context 'with simple objects' do
      context 'with other class (but same origin)' do
        it 'returns different hash values' do
          obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
          obj2 = Line::Bot::V2::MessagingApi::TextMessageV2.new(text: 'Hello')
          expect(obj1.hash).not_to eq(obj2.hash)
        end
      end

      context 'with same class' do
        context 'with same attributes' do
          it 'returns same hash values' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            expect(obj1.hash).to eq(obj2.hash)
          end
        end

        context 'with different attributes' do
          it 'returns different hash values' do
            obj1 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello')
            obj2 = Line::Bot::V2::MessagingApi::TextMessage.new(text: 'World')
            expect(obj1.hash).not_to eq(obj2.hash)
          end
        end
      end
    end

    context 'with nested objects' do
      context 'with same attributes' do
        it 'returns same hash values' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          expect(obj1.hash).to eq(obj2.hash)
        end
      end

      context 'with different attributes' do
        it 'returns different hash values' do
          obj1 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Test Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'vertical',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Test Text')
                ]
              )
            )
          )
          obj2 = Line::Bot::V2::MessagingApi::FlexMessage.new(
            alt_text: 'Different Alt Text',
            contents: Line::Bot::V2::MessagingApi::FlexBubble.new(
              body: Line::Bot::V2::MessagingApi::FlexBox.new(
                layout: 'horizontal',
                contents: [
                  Line::Bot::V2::MessagingApi::FlexText.new(text: 'Different Text') # diff
                ]
              )
            )
          )
          expect(obj1.hash).not_to eq(obj2.hash)
        end
      end
    end
  end
end
