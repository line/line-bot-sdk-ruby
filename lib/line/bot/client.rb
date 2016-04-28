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

      #  @return [String]
      attr_accessor :channel_id, :channel_secret, :channel_mid, :endpoint, :to_channel_id, :proxy

      # Initialize a new Bot Client.
      #
      # @param options [Hash]
      #
      # @return [LINE::Bot::Client]
      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end

      def endpoint
        @endpoint ||= Line::Bot::API::DEFAULT_ENDPOINT
      end

      def to_channel_id
        @to_channel_id ||= Line::Bot::API::DEFAULT_SENDING_MESSAGE_CHANNEL_ID
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

      # Send text to users.
      #
      # @param attrs [Hash]
      #   @param to_mid [String or Array] User's identifiers
      #   @param text [String]
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing :to_mid, :text keys.
      #
      # @return [Net::HTTPResponse]
      def send_text(attrs = {})
        message = Message::Text.new(
          text: attrs[:text],
        )
        send_message(attrs[:to_mid], message)
      end

      # Send image to users.
      #
      # @param attrs [Hash]
      #   @param to_mid [String or Array] User's identifiers
      #   @param image_url [String] Image file's url
      #   @param preview_url [String] Preview image file's url
      #
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

      # Send video to users.
      #
      # @param attrs [Hash]
      #   @param to_mid [String or Array] User's identifiers
      #   @param video_url [String] Video file's url
      #   @param preview_url [String] Preview image file's url
      #
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

      # Send audio to users.
      #
      # @param attrs [Hash]
      #   @param to_mid [String or Array] User's identifiers
      #   @param audio_url [String] Audio file's url
      #   @param duration [String or Integer] Voice message's length, milliseconds
      #
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

      # Send location to users.
      #
      # @param attrs [Hash]
      #   @param to_mid [String or Array] User's identifiers
      #   @param title [String] Location's title
      #   @param address [String] Location's address
      #   @param latitude [Float] Location's latitude
      #   @param longitude [Float] Location's longitude
      #
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

      # Send sticker to users.
      #
      # @param attrs [Hash]
      #   @param to_mid [String or Array] User's identifiers
      #   @param stkpkgid [String or Integer] Sticker's package identifier
      #   @param stkid [String or Integer] Sticker's identifier
      #   @param stkver [String or Integer] Sticker's version number
      #
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

      # Send message to line server and to users.
      #
      # @param to_mid [String or Array] User's identifiers
      # @param message [Line::Bot::Message]
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      #
      # @return [Net::HTTPResponse]
      def send_message(to_mid, message)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.to_channel_id  = to_channel_id
          config.endpoint       = endpoint
          config.endpoint_path  = '/v1/events'
          config.credentials    = credentials
          config.to_mid         = to_mid
          config.message        = message
          config.proxy          = proxy
        end

        request.post
      end

      # Get message content.
      #
      # @param identifier [String] Message's identifier
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      #
      # @return [Net::HTTPResponse]
      def get_message_content(identifier)
        endpoint_path  = "/v1/bot/message/#{identifier}/content"
        get(endpoint_path)
      end

      # Get preview of message content.
      #
      # @param identifier [String] Message's identifier
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      #
      # @return [Net::HTTPResponse]
      def get_message_content_preview(identifier)
        endpoint_path  = "/v1/bot/message/#{identifier}/content/preview"
        get(endpoint_path)
      end

      # Get user profile.
      #
      # @param mids [String or Array] User's identifiers
      #
      # @raise [ArgumentError] Error raised when supplied argument are missing message.
      # @raise [HTTPError]
      #
      # @return [Line::Bot::Response::User::Profile]
      def get_user_profile(mids)
        raise ArgumentError, 'Wrong argument type `mids`' unless mids.instance_of?(String) || mids.instance_of?(Array)

        mids = mids.instance_of?(String) ? [mids] : mids

        raise ArgumentError, 'Wrong argument type `mids`' unless mids.size > 0 && mids.reject {|item| item.instance_of?(String) }

        endpoint_path  = "/v1/profiles?mids=#{mids.join(',')}"

        response = get(endpoint_path)

        Line::Bot::Response::User::Profile.new(response) if !response.value
      end

      # Fetch data, get content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def get(endpoint_path)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.to_channel_id  = to_channel_id
          config.endpoint       = endpoint
          config.endpoint_path  = endpoint_path
          config.credentials    = credentials
          config.proxy          = proxy
        end

        request.get
      end

      # Create rich message to line server and to users.
      #
      # @return [Line::Bot::Builder::RichMessage]
      def rich_message
        Line::Bot::Builder::RichMessage.new(self)
      end

      # Create multiple message to line server and to users.
      #
      # @return [Line::Bot::Builder::MultipleMessage]
      def multiple_message
        Line::Bot::Builder::MultipleMessage.new(self)
      end

      # Validate signature
      #
      # @param content [String] Request's body
      # @param channel_signature [String] Request'header 'X-LINE-ChannelSignature' # HTTP_X_LINE_CHANNELSIGNATURE
      #
      # @return [Boolean]
      def validate_signature(content = "", channel_signature)
        return false unless !channel_signature.nil? && credentials?

        hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, channel_secret, content)
        signature = Base64.strict_encode64(hash)

        variable_secure_compare(channel_signature, signature)
      end

    private
      # Constant time string comparison.
      #
      # via timing attacks.
      # reference: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/security_utils.rb
      # @return [Boolean]
      def variable_secure_compare(a, b)
        secure_compare(::Digest::SHA256.hexdigest(a), ::Digest::SHA256.hexdigest(b))
      end

      # @return [Boolean]
      def secure_compare(a, b)
        return false unless a.bytesize == b.bytesize

        l = a.unpack "C#{a.bytesize}"

        res = 0
        b.each_byte { |byte| res |= byte ^ l.shift }
        res == 0
      end
    end

  end
end
