module Line
  module Bot
    module Receive
      class Message
        attr_reader :id, :from_mid, :to_mid, :from_channel_id, :to_channel_id, :event_type, :created_time, :content

        def initialize(attrs)
          @id = attrs['content']['id']
          @from_mid = attrs['content']['from']
          @to_mid = attrs['content']['to']

          @from_channel_id = attrs['fromChannel']
          @to_channel_id = attrs['toChannel']

          @event_type = attrs['eventType']

          (time, usec) = attrs['content']['createdTime'].to_i.divmod(1000)
          @created_time = Time.at(time, usec)

          @content = create_content(attrs['content'])
        end

        def create_content(attrs)
          case attrs['contentType']
          when Line::Bot::Message::ContentType::TEXT
            return Line::Bot::Message::Text.new(
              text: attrs['text'],
            )
          when Line::Bot::Message::ContentType::IMAGE
            return Line::Bot::Message::Image.new(
              image_url: attrs['originalContentUrl'],
              preview_url: attrs['previewImageUrl'],
            )
          when Line::Bot::Message::ContentType::VIDEO
            return Line::Bot::Message::Video.new(
              video_url: attrs['originalContentUrl'],
              preview_url: attrs['previewImageUrl'],
            )
          when Line::Bot::Message::ContentType::AUDIO
            return Line::Bot::Message::Audio.new(
              audio_url: attrs['originalContentUrl'],
              duration: attrs['contentMetadata']['duration'].to_i,
            )
          when Line::Bot::Message::ContentType::LOCATION
            return Line::Bot::Message::Location.new(
              title: attrs['location']['title'],
              address: attrs['location']['address'],
              latitude: attrs['location']['latitude'],
              longitude: attrs['location']['longitude'],
            )
          when Line::Bot::Message::ContentType::STICKER
            return Line::Bot::Message::Sticker.new(
              stkpkgid: attrs['contentMetadata']['STKPKGID'],
              stkid: attrs['contentMetadata']['STKID'],
              stkver: attrs['contentMetadata']['STKVER'],
            )
          when Line::Bot::Message::ContentType::CONTACT
            return Line::Bot::Message::Contact.new(
              mid: attrs['contentMetadata']['mid'],
              display_name: attrs['contentMetadata']['displayName'],
            )
          else
          end
        end

      end
    end
  end
end
