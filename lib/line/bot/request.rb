require 'line/bot/api/version'
require 'json'
require 'net/http'
require 'uri'

module Line
  module Bot
    class Request
      attr_accessor :endpoint, :endpoint_path, :credentials, :to_mid, :message, :to_channel_id

      # Initializes a new Request
      #
      # @return [LINE::Bot::Request]
      def initialize
        yield(self) if block_given?
      end

      # @return [Net::HTTP]
      def https
        uri = URI(endpoint)
        https = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == "https"
          https.use_ssl = true
        end

        https
      end

      # @return [Array]
      def to
        raise ArgumentError, 'Wrong argument type `to_mid`' unless to_mid.instance_of?(String) || to_mid.instance_of?(Array)
        to = to_mid.instance_of?(String) ? [to_mid] : to_mid

        raise ArgumentError, 'Wrong argument type `to_mid`' unless to.size > 0 && to.all? {|item| item.instance_of?(String) }

        to
      end

      # @return [Line::Bot::Message::Base#content]
      def content
        message.content
      end

      # @return [Hash]
      def payload
        payload = {
          to: to,
          toChannel: to_channel_id,
          eventType: message.event_type.to_s,
          content: content
        }

        payload.to_json
      end

      # @return [Hash]
      def header
        header = {
          'Content-Type' => 'application/json; charset=UTF-8',
          'User-Agent' => "LINE-BotSDK/#{Line::Bot::API::VERSION}",
        }
        hash = credentials.inject({}) { |h, (k, v)| h[k] = v.to_s; h }

        header.merge(hash)
      end

      # Get content of specified URL.
      #
      # @raise [ArgumentError]
      #
      # @return [Net::HTTPResponse]
      def get
        validate_for_getting_message
        https.get(endpoint_path, header)
      end

      # Post content of specified URL.
      #
      # @raise [ArgumentError]
      #
      # @return [Net::HTTPResponse]
      def post
        validate_for_posting_message
        https.post(endpoint_path, payload, header)
      end

      def validate_for_getting_message
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.instance_of?(String)
      end

      def validate_for_posting_message
        raise ArgumentError, 'Invalid argument `message`' unless message.valid?
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.instance_of?(String)
      end

    end
  end
end
