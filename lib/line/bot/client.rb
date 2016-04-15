require 'line/bot/message'
require 'line/bot/request'
require 'line/bot/builder/rich_message'
require 'line/bot/builder/multiple_message'
require 'line/bot/api/errors'
require 'base64'
require 'net/http'

module Line
  module Bot
    class Client
      attr_accessor :channel_id, :channel_secret, :channel_mid

      # Initializes a new Bot Client
      #
      # @param options [Hash]
      # @return [LINE::Bot::Client]
      def initialize
        yield(self) if block_given?
      end

      # @return [Hash]
      def credentials
        {
          'X-Line-ChannelID' => channel_id,
          'X-Line-ChannelSecret' => channel_secret,
          'X-Line-Trusted-User-With-ACL' => channel_mid,
        }
      end

      def credentials?
        credentials.values.all?
      end

      # Sends text to users
      #
      # @param attrs [Hash]
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param attrs [:text] [String]
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :text keys.
      #
      # @return [Net::HTTPResponse]
      def send_text(attrs = {})
        message = Message::Text.new(
          text: attrs[:text],
        )
        send_message(attrs[:to_mid], message)
      end

      # Sends image to users
      #
      # @param attrs [Hash]
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param attrs [:image_url] [String] Image file's url
      # @param attrs [:preview_url] [String] Preview image file's url
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :image_url, :preview_url keys.
      #
      # @return [Net::HTTPResponse]
      def send_image(attrs = {})
        message = Message::Image.new(
          image_url: attrs[:image_url],
          preview_url: attrs[:preview_url],
        )
        send_message(attrs[:to_mid], message)
      end

      # Sends video to users
      #
      # @param attrs [Hash]
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param attrs [:video_url] [String] Video file's url
      # @param attrs [:preview_url] [String] Preview image file's url
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :video_url, :preview_url keys.
      #
      # @return [Net::HTTPResponse]
      def send_video(attrs = {})
        message = Message::Video.new(
          video_url: attrs[:video_url],
          preview_url: attrs[:preview_url],
        )
        send_message(attrs[:to_mid], message)
      end

      # Sends audio to users
      #
      # @param attrs [Hash]
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param attrs [:audio_url] [String] Audio file's url
      # @param attrs [:duration] [String or Integer] Voice message's length, milliseconds
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :audio_url, :duration keys.
      #
      # @return [Net::HTTPResponse]
      def send_audio(attrs = {})
        message = Message::Audio.new(
          audio_url: attrs[:audio_url],
          duration: attrs[:duration],
        )
        send_message(attrs[:to_mid], message)
      end

      # Sends location to users
      #
      # @param attrs [Hash]
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param attrs [:title] [String] Location's title
      # @param attrs [:address] [String] Location's address
      # @param attrs [:latitude] [Float] Location's latitude
      # @param attrs [:longitude] [Float] Location's longitude
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :title, :latitude, :longitude keys.
      #
      # @return [Net::HTTPResponse]
      def send_location(attrs = {})
        message = Message::Location.new(
          title: attrs[:title],
          address: attrs[:address],
          latitude: attrs[:latitude],
          longitude: attrs[:longitude],
        )
        send_message(attrs[:to_mid], message)
      end

      # Sends sticker to users
      #
      # @param attrs [Hash]
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param attrs [:stkpkgid] [String or Integer] Sticker's package identifier
      # @param attrs [:stkid] [String or Integer] Sticker's identifier
      # @param attrs [:stkver] [String or Integer] Sticker's version number
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :stkpkgid, :stkid, :stkver keys.
      #
      # @return [Net::HTTPResponse]
      def send_sticker(attrs = {})
        message = Message::Sticker.new(
          stkpkgid: attrs[:stkpkgid],
          stkid: attrs[:stkid],
          stkver: attrs[:stkver],
        )
        send_message(attrs[:to_mid], message)
      end

      # Sends message to line server and to users
      #
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      # @param message [Line::Bot::Message]
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      #
      # @return [Net::HTTPResponse]
      def send_message(to_mid, message)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.endpoint_path  = '/v1/events'
          config.credentials    = credentials
          config.to_mid         = to_mid
          config.message        = message
        end

        request.post
      end

      # Gets message content
      #
      # @param identifer [String] Message's identifier
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      #
      # @return [Net::HTTPResponse]
      def get_message_content(identifer)
        endpoint_path  = "/v1/bot/message/#{identifer}/content"
        get(endpoint_path)
      end

      # Gets preview of message content
      #
      # @param identifer [String] Message's identifier
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      #
      # @return [Net::HTTPResponse]
      def get_message_content_preview(identifer)
        endpoint_path  = "/v1/bot/message/#{identifer}/content/preview"
        get(endpoint_path)
      end

      # Gets user profile
      #
      # @param attrs [:to_mid] [String or Array] User's indentifiers
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      # @raise [HTTPError]
      #
      # @return [Line::Bot::Response::User::Profile]
      def get_user_profile(mids)
        mids = mids.instance_of?(String) ? [mids] : mids
        endpoint_path  = "/v1/profiles?mids=#{mids.join(',')}"

        response = get(endpoint_path)

        Line::Bot::Response::User::Profile.new(response) if !response.value
      end

      # Fetches data
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def get(endpoint_path)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.endpoint_path  = endpoint_path
          config.credentials    = credentials
        end

        request.get
      end

      # Creates rich message to line server and to users
      #
      # @return [Line::Bot::Builder::RichMessage]
      def rich_message
        Line::Bot::Builder::RichMessage.new(self)
      end

      # Creates multiple message to line server and to users
      #
      # @return [Line::Bot::Builder::MultipleMessage]
      def multiple_message
        Line::Bot::Builder::MultipleMessage.new(self)
      end

      # Validates signature
      #
      # @param content [String] Request's body
      # @param channel_signature [String] Request'header 'X-LINE-ChannelSignature' # HTTP_X_LINE_CHANNELSIGNATURE
      #
      # @return [Boolean]
      def validate_signature(content = "", channel_signature)
        return false unless !channel_signature.nil? && credentials?

        hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, channel_secret, content)
        signature = Base64.strict_encode64(hash)

        channel_signature == signature
      end
    end

  end
end
