require 'line/bot/message'
require 'json'

module Line
  module Bot
    module Builder
      class RichMessage

        def initialize(client)
          @actions ||= {}
          @listeners ||= []
          @client = client
        end

        def set_action(attrs = {})
          tap {
            attrs.each { |key, value|
              raise ArgumentError, 'Invalid arguments, :text, :link_url keys.' unless validate_action_attributes(value)

              @actions[key.to_s] ||= {}
              @actions[key.to_s] = {
                type: 'web',
                text: value[:text].to_s,
                params: {
                  linkUri: value[:link_url].to_s
                },
              }
            }
          }
        end

        def validate_action_attributes(attrs = {})
          attrs[:text] && attrs[:link_url]
        end

        def add_listener(attrs = {})
          tap {
            raise ArgumentError, 'Invalid arguments, :x [Fixnum], :y [Fixnum], :width [Fixnum], :height [Fixnum] keys.' unless validate_listener_attributes(attrs)

            listener = {
              type: 'touch', # Fixed "touch".
              params: [attrs[:x], attrs[:y], attrs[:width], attrs[:height]],
              action: attrs[:action],
            }
            @listeners << listener
          }
        end

        def validate_listener_attributes(attrs = {})
          attrs[:action].instance_of?(String) &&
          attrs[:x].instance_of?(Fixnum) &&
          attrs[:y].instance_of?(Fixnum) &&
          attrs[:width].instance_of?(Fixnum) &&
          attrs[:height].instance_of?(Fixnum)
        end

        # send rich message to line server and to users
        #
        # @param attrs [Hash]
        # @param attrs [:to_mid] [String or Array] line user's mids
        # @param attrs [:image_url] [String] image file's url
        # @param attrs [:alt_text] [String] alt text for image file's url
        # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :image_url, :preview_url keys.
        #
        # @return [Net::HTTPResponse] response for a request to line server
        def send(attrs = {})
          @image_url = attrs[:image_url]
          @alt_text = attrs[:alt_text]

          @client.send_message(attrs[:to_mid], self)
        end

        def height
          height = 0
          @listeners.each { |listener|
            h = listener[:params][1] + listener[:params][3] # params.y + params.height
            height = h if height < h
          }

          height > 2080 ? 2080 : height
        end

        def event_type
          Line::Bot::EventType::MESSAGE
        end

        def content
          {
            contentType: Line::Bot::Message::ContentType::RICH_MESSAGE,
            toType: 1,
            contentMetadata: {
              DOWNLOAD_URL: @image_url,
              SPEC_REV: "1", # Fixed "1".
              ALT_TEXT: @alt_text,
              MARKUP_JSON: markup_json,
            },
          }
        end

        def valid?
          @image_url && @alt_text
        end

        def markup_json
          {
            canvas: {
              height: height,
              width: 1040, # Integer fixed value: 1040
              initialScene: 'scene1',
            },
            images: {
              image1: {
                x: 0,
                y: 0,
                w: 1040, # Integer fixed value: 1040
                h: height
              },
            },
            actions: @actions,
            scenes: {
              scene1: {
                draws: {
                  image: 'image1', # Use the image ID "image1".
                  x: 0,
                  y: 0,
                  w: 1040, # Integer fixed value: 1040
                  h: height
                },
                listeners: @listeners
              }
            }
          }.to_json
        end

      end
    end
  end
end
