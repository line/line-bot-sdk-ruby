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

      # @return [Hash]
      attr_accessor :http_options, :additional_headers

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
        headers = (@additional_headers || {}).merge({
          'User-Agent' => "LINE-BotSDK-Ruby/#{Line::Bot::API::VERSION}",
          'Authorization' => "Bearer #{channel_token}",
        })
        @httpclient ||= Line::Bot::HttpClient.new(
          http_options: http_options,
          default_headers: headers
        )
      end

      def endpoint
        @endpoint ||= Line::Bot::API::DEFAULT_ENDPOINT
      end

      # Push messages to line server and to user.
      #
      # @param user_id [String] User's identifiers
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def push_message(user_id, messages)
        httpclient.post_json("#{endpoint}/bot/message/push", {
          to: user_id,
          messages: ensure_array(messages)
        })
      end

      # Reply messages to line server and to users.
      #
      # @param token [String]
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def reply_message(token, messages)
        httpclient.post_json("#{endpoint}/bot/message/reply", {
          replyToken: token,
          messages: ensure_array(messages)
        })
      end

      # Multicast messages to line server and to users.
      #
      # @param to [Array or String]
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def multicast(user_ids, messages)
        httpclient.post_json("#{endpoint}/bot/message/multicast", {
          to: ensure_array(user_ids),
          messages: ensure_array(messages)
        })
      end

      # Broadcast messages to line server and to users.
      #
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def broadcast(messages)
        httpclient.post_json("#{endpoint}/bot/message/broadcast", {
          messages: ensure_array(messages)
        })
      end

      def leave_group(group_id)
        httpclient.post_json("#{endpoint}/bot/group/#{group_id}/leave", '')
      end

      def leave_room(room_id)
        httpclient.post_json("#{endpoint}/bot/room/#{room_id}/leave", '')
      end

      # Get message content.
      #
      # @param identifier [String] Message's identifier
      #
      # @return [Net::HTTPResponse]
      def get_message_content(identifier)
        httpclient.get("#{endpoint}/bot/message/#{identifier}/content")
      end

      # Get an user's profile.
      #
      # @param user_id [String] User's identifier
      #
      # @return [Net::HTTPResponse]
      def get_profile(user_id)
        httpclient.get("#{endpoint}/bot/profile/#{user_id}")
      end

      # Get an user's profile of a group.
      #
      # @param group_id [String] Group's identifier
      # @param user_id [String] User's identifier
      #
      # @return [Net::HTTPResponse]
      def get_group_member_profile(group_id, user_id)
        httpclient.get("#{endpoint}/bot/group/#{group_id}/member/#{user_id}")
      end

      # Get an user's profile of a room.
      #
      # @param room_id [String] Room's identifier
      # @param user_id [String] User's identifier
      #
      # @return [Net::HTTPResponse]
      def get_room_member_profile(room_id, user_id)
        httpclient.get("#{endpoint}/bot/room/#{room_id}/member/#{user_id}")
      end

      # Get user IDs of a group
      #
      # @param group_id [String] Group's identifier
      # @param continuation_token [String] Identifier to return next page
      #                                   (next property to be included in the response)
      #
      # @return [Net::HTTPResponse]
      def get_group_member_ids(group_id, continuation_token = nil)
        query = {}
        query['start'] = continuation_token if continuation_token
        httpclient.get("#{endpoint}/bot/group/#{group_id}/members/ids", query: query)
      end

      # Get user IDs of a room
      #
      # @param group_id [String] Room's identifier
      # @param continuation_token [String] Identifier to return next page
      #                                   (next property to be included in the response)
      #
      # @return [Net::HTTPResponse]
      def get_room_member_ids(room_id, continuation_token = nil)
        query = {}
        query['start'] = continuation_token if continuation_token
        httpclient.get("#{endpoint}/bot/room/#{room_id}/members/ids", query: query)
      end

      # Get a list of all uploaded rich menus
      #
      # @return [Net::HTTPResponse]
      def get_rich_menus
        httpclient.get("#{endpoint}/bot/richmenu/list")
      end

      # Get a rich menu via a rich menu ID
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def get_rich_menu(rich_menu_id)
        httpclient.get("#{endpoint}/bot/richmenu/#{rich_menu_id}")
      end

      # Gets the number of messages sent with the /bot/message/reply endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_reply(date)
        httpclient.get("#{endpoint}/bot/message/delivery/reply", query: {date: date})
      end

      # Gets the number of messages sent with the /bot/message/push endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_push(date)
        httpclient.get("#{endpoint}/bot/message/delivery/push", query: {date: date})
      end

      # Gets the number of messages sent with the /bot/message/multicast endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_multicast(date)
        httpclient.get("#{endpoint}/bot/message/delivery/multicast", query: {date: date})
      end

      # Gets the number of messages sent with the /bot/message/broadcast endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_broadcast(date)
        httpclient.get("#{endpoint}/bot/message/delivery/broadcast", query: {date: date})
      end

      # Create a rich menu
      #
      # @param rich_menu [Hash] The rich menu represented as a rich menu object
      #
      # @return [Net::HTTPResponse]
      def create_rich_menu(rich_menu)
        httpclient.post_json("#{endpoint}/bot/richmenu", rich_menu)
      end

      # Delete a rich menu
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def delete_rich_menu(rich_menu_id)
        httpclient.delete("#{endpoint}/bot/richmenu/#{rich_menu_id}")
      end

      # Get the ID of the rich menu linked to a user
      #
      # @param user_id [String] ID of the user
      #
      # @return [Net::HTTPResponse]
      def get_user_rich_menu(user_id)
        httpclient.get("#{endpoint}/bot/user/#{user_id}/richmenu")
      end

      # Get default rich menu
      #
      # @return [Net::HTTPResponse]
      def get_default_rich_menu
        httpclient.get("#{endpoint}/bot/user/all/richmenu")
      end

      # Set default rich menu (Link a rich menu to all user)
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def set_default_rich_menu(rich_menu_id)
        httpclient.post_json("#{endpoint}/bot/user/all/richmenu/#{rich_menu_id}", '')
      end

      # Unset default rich menu (Unlink a rich menu from all user)
      #
      # @return [Net::HTTPResponse]
      def unset_default_rich_menu
        httpclient.delete("#{endpoint}/bot/user/all/richmenu")
      end

      # Link a rich menu to a user
      #
      # @param user_id [String] ID of the user
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def link_user_rich_menu(user_id, rich_menu_id)
        httpclient.post("#{endpoint}/bot/user/#{user_id}/richmenu/#{rich_menu_id}", '')
      end

      # Unlink a rich menu from a user
      #
      # @param user_id [String] ID of the user
      #
      # @return [Net::HTTPResponse]
      def unlink_user_rich_menu(user_id)
        httpclient.delete("#{endpoint}/bot/user/#{user_id}/richmenu")
      end

      # To link a rich menu to multiple users at a time
      #
      # @param user_ids [Array] ID of the user
      # @param rich_menu_id [String] ID of the uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def bulk_link_rich_menus(user_ids, rich_menu_id)
        httpclient.post("#{endpoint}/bot/richmenu/bulk/link", {richMenuId: rich_menu_id, userIds: user_ids})
      end

      # To unlink a rich menu from multiple users at a time
      #
      # @param user_ids [Array] ID of the user
      #
      # @return [Net::HTTPResponse]
      def bulk_unlink_rich_menus(user_ids)
        httpclient.post("#{endpoint}/bot/richmenu/bulk/unlink", {userIds: user_ids})
      end

      # Download an image associated with a rich menu
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def get_rich_menu_image(rich_menu_id)
        httpclient.get("#{endpoint}/bot/richmenu/#{rich_menu_id}/content")
      end

      # Upload and attaches an image to a rich menu
      #
      # @param rich_menu_id [String] The ID of the rich menu to attach the image to
      # @param file [File] Image file to attach rich menu
      #
      # @return [Net::HTTPResponse]
      def create_rich_menu_image(rich_menu_id, file)
        httpclient.post_file("#{endpoint}/bot/richmenu/#{rich_menu_id}/content", file)
      end

      # Issue a link token to a user
      #
      # @param user_id [String] ID of the user
      #
      # @return [Net::HTTPResponse]
      def create_link_token(user_id)
        httpclient.post("#{endpoint}/bot/user/#{user_id}/linkToken", '')
      end

      # Get the target limit for additional messages
      #
      # @return [Net::HTTPResponse]
      def get_quota
        httpclient.get("#{endpoint}/bot/message/quota")
      end

      # Get number of messages sent this month
      #
      # @return [Net::HTTPResponse]
      def get_quota_consumption
        httpclient.get("#{endpoint}/bot/message/quota/consumption")
      end

      # Fetch data, get content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def get(endpoint_path, query: {}, header: {})
        httpclient.get("#{endpoint}#{endpoint_path}", query: query, header: header)
      end

      # Post data, get content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def post(endpoint_path, payload = nil, query: {}, header: {})
        httpclient.post_json("#{endpoint}#{endpoint_path}", payload, query: query, header: header)
      end

      # Delete content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def delete(endpoint_path, query: {}, header: {})
        httpclient.delete("#{endpoint}#{endpoint_path}", query: query, header: header)
      end

      # Parse events from request.body
      #
      # @param request_body [String]
      #
      # @return [Array<Line::Bot::Event::Class>]
      def parse_events_from(request_body)
        json = JSON.parse(request_body)

        json['events'].map do |item|
          begin
            klass = Line::Bot::Event.const_get(Line::Bot::Util.camelize(item['type']))
            klass.new(item)
          rescue NameError
            Line::Bot::Event::Base.new(item)
          end
        end
      end

      # Validate signature
      #
      # @param content [String] Request's body
      # @param channel_signature [String] Request'header 'X-LINE-Signature' # HTTP_X_LINE_SIGNATURE
      #
      # @return [Boolean]
      def validate_signature(content, channel_signature)
        return false if !channel_signature || !channel_secret

        hash = OpenSSL::HMAC.digest(OpenSSL::Digest::SHA256.new, channel_secret, content)
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
        a = ::Digest::SHA256.hexdigest(a)
        b = ::Digest::SHA256.hexdigest(b)

        return false unless a.bytesize == b.bytesize

        l = a.unpack "C#{a.bytesize}"

        res = 0
        b.each_byte { |byte| res |= byte ^ l.shift }
        res == 0
      end

      def ensure_array(array_or_hash)
        array_or_hash.is_a?(Array) ? array_or_hash : [array_or_hash]
      end
    end
  end
end
