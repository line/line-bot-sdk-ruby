require 'spec_helper'

describe 'Line::Bot::V2::MessagingApi::FlexContainer' do
  describe '#create' do
    context 'with parsed JSON string' do
      let(:original_json_string) do
        <<~JSON
          {
            "type": "bubble",
            "body": {
              "type": "box",
              "layout": "horizontal",
              "contents": [
                {
                  "type": "text",
                  "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  "wrap": true,
                  "color": "#ff0000",
                  "flex": 2
                },
                {
                  "type": "text",
                  "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                }
              ]
            },
            "footer": {
              "type": "box",
              "layout": "horizontal",
              "contents": [
                {
                  "type": "image",
                  "url": "https://example.com/flex/images/image.jpg",
                  "animated": true,
                  "size": "xs",
                  "action": {
                    "type": "uri",
                    "uri": "https://example.com"
                  }
                },
                {
                  "type": "image",
                  "url": "https://example.com/flex/images/image.jpg",
                  "animated": true,
                  "size": "xs"
                }
              ]
            }
          }
        JSON
      end

      let(:container_instance) do
        Line::Bot::V2::MessagingApi::FlexContainer.create(JSON.parse(original_json_string))
      end

      it 'creates a valid Line::Bot::V2::MessagingAPI::FlexContainer' do
        expect(container_instance).to be_a(Line::Bot::V2::MessagingApi::FlexContainer)

        expect(container_instance.class).to eq(Line::Bot::V2::MessagingApi::FlexBubble)
        expect(container_instance.type).to eq('bubble')
        expect(container_instance.body).to be_a(Line::Bot::V2::MessagingApi::FlexBox)
        expect(container_instance.body.type).to eq('box')
        expect(container_instance.body.layout).to eq('horizontal')
        expect(container_instance.body.contents).to be_a(Array)
        expect(container_instance.body.contents.size).to eq(2)

        expect(container_instance.body.contents[0]).to be_a(Line::Bot::V2::MessagingApi::FlexText)
        expect(container_instance.body.contents[0].text).to eq('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
        expect(container_instance.body.contents[0].wrap).to eq(true)
        expect(container_instance.body.contents[0].color).to eq('#ff0000')
        expect(container_instance.body.contents[0].flex).to eq(2)

        expect(container_instance.body.contents[1]).to be_a(Line::Bot::V2::MessagingApi::FlexText)
        expect(container_instance.body.contents[1].text).to eq('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')
        expect(container_instance.body.contents[1].wrap).to be_nil
        expect(container_instance.body.contents[1].color).to be_nil
        expect(container_instance.body.contents[1].flex).to be_nil

        expect(container_instance.footer).to be_a(Line::Bot::V2::MessagingApi::FlexBox)
        expect(container_instance.footer.type).to eq('box')
        expect(container_instance.footer.layout).to eq('horizontal')
        expect(container_instance.footer.contents).to be_a(Array)
        expect(container_instance.footer.contents.size).to eq(2)

        expect(container_instance.footer.contents[0]).to be_a(Line::Bot::V2::MessagingApi::FlexImage)
        expect(container_instance.footer.contents[0].url).to eq('https://example.com/flex/images/image.jpg')
        expect(container_instance.footer.contents[0].animated).to eq(true)
        expect(container_instance.footer.contents[0].size).to eq('xs')
        expect(container_instance.footer.contents[0].action).to be_a(Line::Bot::V2::MessagingApi::URIAction)
        expect(container_instance.footer.contents[0].action.type).to eq('uri')
        expect(container_instance.footer.contents[0].action.uri).to eq('https://example.com')

        expect(container_instance.footer.contents[1]).to be_a(Line::Bot::V2::MessagingApi::FlexImage)
        expect(container_instance.footer.contents[1].url).to eq('https://example.com/flex/images/image.jpg')
        expect(container_instance.footer.contents[1].animated).to eq(true)
        expect(container_instance.footer.contents[1].size).to eq('xs')
        expect(container_instance.footer.contents[1].action).to be_nil
      end

      it 'represents the same JSON contents' do
        json_string_from_instance = Line::Bot::V2::Utils.deep_compact(
          Line::Bot::V2::Utils.deep_camelize(
            Line::Bot::V2::Utils.deep_to_hash(container_instance)
          )
        ).to_json

        expect(JSON.parse(json_string_from_instance)).to eq(JSON.parse(original_json_string)) # ignore order
      end
    end
  end
end
