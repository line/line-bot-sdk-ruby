require 'line/bot/api/version'
require 'line/bot/utils'
require 'json'
require 'net/http'
require 'uri'

module Line
  module Bot
    class Request
      attr_accessor :endpoint, :endpoint_path, :credentials, :to_mid, :message, :to_channel_id, :httpclient

      include Line::Bot::Utils

      # Initializes a new Request
      #
      # @return [Line::Bot::Request]
      def initialize
        yield(self) if block_given?
      end

      # @return [Array]
      def to
        to_mid.is_a?(String) ? [to_mid] : to_mid
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
        assert_for_getting_message
        httpclient.get(endpoint + endpoint_path, header)
      end

      # Post content of specified URL.
      #
      # @raise [ArgumentError]
      #
      # @return [Net::HTTPResponse]
      def post
        assert_for_posting_message
        httpclient.post(endpoint + endpoint_path, payload, header)
      end

      def assert_for_getting_message
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.is_a?(String)
      end

      def assert_for_posting_message
        raise ArgumentError, 'Wrong argument type `to_mid`' unless validate_mids(to)
        raise ArgumentError, 'Invalid argument `message`' unless message.valid?
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.is_a?(String)
      end

    end
  end
end
