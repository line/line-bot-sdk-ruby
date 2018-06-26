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

require 'line/bot/api/version'
require 'json'
require 'net/http'
require 'uri'

module Line
  module Bot
    class Request
      attr_accessor :endpoint, :endpoint_path, :credentials, :to, :reply_token, :messages, :httpclient, :payload, :file

      # Initializes a new Request
      #
      # @return [Line::Bot::Request]
      def initialize
        yield(self) if block_given?
      end

      # @return [String]
      def payload
        return file.seek(0) && file.read if file.is_a? File
        return @payload if @payload.is_a? String
        payload = {
          to: to,
          replyToken: reply_token,
          messages: messages
        }

        payload.delete_if { |k, v| v.nil? }.to_json
      end

      # @return [Hash]
      def header
        content_type =
          if file.is_a? File
            case file.path
            when /\.png\z/i then 'image/png'
            when /\.jpe?g\z/i then 'image/jpeg'
            else
              raise ArgumentError.new("invalid file extension: #{file.path}")
            end
          else
            'application/json; charset=UTF-8'
          end

        header = {
          'Content-Type' => content_type,
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

      def delete
        assert_for_deleting_message
        httpclient.delete(endpoint + endpoint_path, header)
      end

      def assert_for_getting_message
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.is_a?(String)
      end

      def assert_for_posting_message
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.is_a?(String)
      end

      def assert_for_deleting_message
        raise ArgumentError, 'Wrong argument type `endpoint_path`' unless endpoint_path.is_a?(String)
      end
    end
  end
end
