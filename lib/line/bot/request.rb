require 'line/bot/api/version'
require 'json'
require 'net/http'
require 'uri'

module Line
  module Bot
    class Request
      attr_accessor :endpoint, :endpoint_path, :credentials, :to, :reply_token, :messages, :httpclient

      # Initializes a new Request
      #
      # @return [Line::Bot::Request]
      def initialize
        yield(self) if block_given?
      end

      # @return [Hash]
      def payload
        payload = {
          to: to,
          replyToken: reply_token,
          messages: messages
        }

        payload.delete_if{|k, v| v.nil?}.to_json
      end

      # @return [Hash]
      def header
        header = {
          'Content-Type' => 'application/json; charset=UTF-8',
          'User-Agent' => "LINE-BotSDK-Ruby/#{Line::Bot::API::VERSION}",
        }
        hash = credentials.inject({}) { |h, (k, v)| h[k] = v.to_s; h }

        header.merge(hash)
      end

      # Get content of specified URL.
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
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.is_a?(String)
      end

    end
  end
end
