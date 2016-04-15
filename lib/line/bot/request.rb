require 'line/bot/api/version'
require 'json'
require 'net/http'

module Line
  module Bot
    class Request
      attr_accessor :endpoint_path, :credentials, :to_mid, :message

      def initialize
        yield(self) if block_given?
      end

      def https
        https = Net::HTTP.new('trialbot-api.line.me', 443)
        https.use_ssl = true

        https
      end

      def to
        to_mid.instance_of?(String) ? [to_mid] : to_mid
      end

      def content
        message.content
      end

      def payload
        payload = {
          to: to,
          toChannel: 1383378250, # Fixed  value
          eventType: message.event_type.to_s,
          content: content
        }

        payload.to_json
      end

      def header
        header = {
          'Content-Type' => 'application/json; charset=UTF-8',
          'User-Agent' => "LINE-BotSDK/#{Line::Bot::API::VERSION}",
        }
        hash = credentials.inject({}) { |h, (k, v)| h[k] = v.to_s; h }

        header.merge(hash)
      end

      def get
        raise ArgumentError, "Invalid arguments" unless validate_for_getting_message?

        https.get(endpoint_path, header)
      end

      def post
        raise ArgumentError, "Invalid arguments" unless validate_for_posting_message?

        https.post(endpoint_path, payload, header)
      end

      def validate_for_getting_message?
        !endpoint_path.nil?
      end

      def validate_for_posting_message?
        to.size > 0 && message.valid? && endpoint_path
      end

    end
  end
end
