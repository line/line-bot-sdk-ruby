require 'base64'
require 'json'
require 'openssl'

require 'line/bot/v2/utils'
require 'line/bot/v2/webhook/core'

module Line
  module Bot
    module V2
      class WebhookParser
        class InvalidSignatureError < StandardError; end

        def initialize(channel_secret:)
          @channel_secret = channel_secret
        end

        # Parse events from the raw request body and validate the signature.
        #
        # @param body [String]
        #   The unmodified request body (exactly as received).
        # @param signature [String]
        #   The value of the 'X-LINE-Signature' header.
        # @return [Array<Line::Bot::V2::Webhook::Event>]
        #   An array of event objects. Recognized events become instances of classes
        #   under `Line::Bot::V2::Webhook::*Event`;
        #   `Line::Bot::V2::Webhook::Event` is returned as fallback only when the event class is not defined in line-bot-sdk library.
        #   When you update the SDK, you may not need to handle `Line::Bot::V2::Webhook::Event` anymore.
        # @raise [InvalidSignatureError]
        #   If the signature fails verification.
        #
        # @example Sinatra usage
        #   def parser
        #     @parser ||= Line::Bot::V2::WebhookParser.new(channel_secret: ENV.fetch("LINE_CHANNEL_SECRET"))
        #   end
        #
        #   post '/callback' do
        #     body = request.body.read
        #     signature = request.env['HTTP_X_LINE_SIGNATURE']
        #
        #     begin
        #       events = parser.parse(body: body, signature: signature)
        #     rescue Line::Bot::V2::WebhookParser::InvalidSignatureError
        #       halt 400, { 'Content-Type' => 'text/plain' }, 'Bad Request'
        #     end
        #
        #     # Handle events...
        #     events.each do |event|
        #       case event
        #       when Line::Bot::V2::Webhook::MessageEvent
        #         handle_message_event(event)
        #       ...
        #     end
        #     "OK"
        #   end
        def parse(body:, signature:)
          raise InvalidSignatureError.new("Invalid signature: #{signature}") unless verify_signature(body: body, signature: signature)

          data = JSON.parse(body.chomp, symbolize_names: true)
          data = Line::Bot::V2::Utils.deep_underscore(data)
          data = Line::Bot::V2::Utils.deep_convert_reserved_words(data)
          data = Line::Bot::V2::Utils.deep_symbolize(data)

          data[:events].map do |event|
            Line::Bot::V2::Webhook::Event.create(**event) # steep:ignore
          end
        end

        private

        def verify_signature(body:, signature:)
          hash = OpenSSL::HMAC.digest(OpenSSL::Digest.new('SHA256'), @channel_secret, body)
          expected = Base64.strict_encode64(hash)
          variable_secure_compare(signature, expected)
        end

        # To avoid timing attacks
        def variable_secure_compare(a, b)
          secure_compare(::Digest::SHA256.hexdigest(a), ::Digest::SHA256.hexdigest(b))
        end

        def secure_compare(a, b)
          return false unless a.bytesize == b.bytesize

          l = a.unpack("C#{a.bytesize}")

          res = 0
          b.each_byte { |byte| res |= byte ^ l.shift } # steep:ignore ArgumentTypeMismatch
          res == 0
        end
      end
    end
  end
end
