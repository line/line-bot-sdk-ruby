# Copyright 2016 LINE
#
# LINE Corporation licenses this file to you under the Apache License,
# version 2.0 (the "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

require 'line/bot/request'
require 'line/bot/api/errors'
require 'base64'
require 'net/http'
require 'openssl'

module Line
  module Bot
    class Client

      #  @return [String]
      attr_accessor :channel_token, :channel_secret, :endpoint

      # @return [Object]
      attr_accessor :httpclient

      # Initialize a new Bot Client.
      #
      # @param options [Hash]
      #
      # @return [Line::Bot::Client]
      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end

      def httpclient
        @httpclient ||= Line::Bot::HTTPClient.new
      end

      def endpoint
        @endpoint ||= Line::Bot::API::DEFAULT_ENDPOINT
      end

      # @return [Hash]
      def credentials
        {
          "Authorization" => "Bearer #{channel_token}",
        }
      end

      def credentials?
        credentials.values.all?
      end

      # Push messages to line server and to users.
      #
      # @param user_id [String] User's identifiers
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def push_message(user_id, messages)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        messages = [messages] if messages.is_a?(Hash)

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/message/push'
          config.credentials    = credentials
          config.to             = user_id
          config.messages       = messages
        end

        request.post
      end

      # Reply messages to line server and to users.
      #
      # @param token [String]
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def reply_message(token, messages)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        messages = [messages] if messages.is_a?(Hash)

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/message/reply'
          config.credentials    = credentials
          config.reply_token    = token
          config.messages       = messages
        end

        request.post
      end

      def leave_group(group_id)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = "/group/#{group_id}/leave"
          config.credentials    = credentials
        end

        request.post
      end

      def leave_room(room_id)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = "/room/#{room_id}/leave"
          config.credentials    = credentials
        end

        request.post
      end

      # Get message content.
      #
      # @param identifier [String] Message's identifier
      #
      # @return [Net::HTTPResponse]
      def get_message_content(identifier)
        endpoint_path  = "/message/#{identifier}/content"
        get(endpoint_path)
      end

      # Get an user's profile.
      #
      # @param user_id [String] User's identifiers
      #
      # @return [Net::HTTPResponse]
      def get_profile(user_id)
        endpoint_path  = "/profile/#{user_id}"
        get(endpoint_path)
      end

      # Fetch data, get content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def get(endpoint_path)
        raise Line::Bot::API::InvalidCredentialsError, 'Invalidates credentials' unless credentials?

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = endpoint_path
          config.credentials    = credentials
        end

        request.get
      end

      # Parse events from request.body
      #
      # @param request_body [String]
      #
      # @return [Array<Line::Bot::Event::Class>]
      def parse_events_from(request_body)
        json = JSON.parse(request_body)

        json['events'].map { |item|
          begin
            klass = Line::Bot::Event.const_get(item['type'].capitalize)
            klass.new(item)
          rescue NameError => e
            Line::Bot::Event::Base.new(item)
          end
        }
      end

      # Validate signature
      #
      # @param content [String] Request's body
      # @param channel_signature [String] Request'header 'X-LINE-Signature' # HTTP_X_LINE_SIGNATURE
      #
      # @return [Boolean]
      def validate_signature(content = "", channel_signature)
        return false if !channel_signature || !channel_secret

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
