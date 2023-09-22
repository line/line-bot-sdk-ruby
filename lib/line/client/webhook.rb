module LINE
  module Client
    module Webhook
      class << self
        # Verify that the request was sent from the LINE Platform
        #
        # @param body [String] Request body
        # @param signature [String] x-line-signature in the request header
        # @param channel_secret [String] Channel secret
        #
        # @return [Boolean]
        def validate_signature(body, signature, channel_secret)
          digest = OpenSSL::HMAC.digest(OpenSSL::Digest.new('SHA256'), channel_secret, body)
          signature == Base64.strict_encode64(digest)
        end

        # Parse events from the request body
        #
        # @param body [String] Request body
        #
        # @return [Array<LINE::Client::Webhook::Event>]
        def parse_events_from(body)
          json = JSON.parse(body)
          json = underscore(json)
          json['events'].map do |event|
            class_name = event['type'].gsub(/^./, &:upcase)
            begin
              LINE::Client::Webhook.const_get("#{class_name}Event").new(event)
            rescue NameError
              LINE::Client::Webhook::Event.new(event)
            end
          end
        end

        private

        def underscore(object)
          case object
          when Hash
            object.transform_keys! { |key| key.gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase }
            object.transform_values! { |value| underscore(value) }
          when Array
            object.map! { |value| underscore(value) }
          end
          object
        end
      end
    end
  end
end
