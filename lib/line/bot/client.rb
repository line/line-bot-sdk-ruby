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
require 'base64'
require 'net/http'
require 'openssl'
require 'uri'

module Line
  module Bot
    class Client
      #  @return [String]
      attr_accessor :channel_token, :channel_id, :channel_secret, :endpoint

      # @return [Object]
      attr_accessor :httpclient

      # @return [Hash]
      attr_accessor :http_options

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
        @httpclient ||= Line::Bot::HTTPClient.new(http_options)
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

      # Issue channel access token
      #
      # @param grant_type [String] Grant type
      #
      # @return [Net::HTTPResponse]
      def issue_channel_token(grant_type = 'client_credentials')
        channel_id_required
        channel_secret_required

        payload = URI.encode_www_form(
          grant_type:    grant_type,
          client_id:     channel_id,
          client_secret: channel_secret
        )

        request = Request.new do |config|
          config.httpclient    = httpclient
          config.endpoint      = endpoint
          config.endpoint_path = '/oauth/accessToken'
          config.content_type  = 'application/x-www-form-urlencoded'
          config.payload       = payload
        end

        request.post
      end

      # Revoke channel access token
      #
      # @return [Net::HTTPResponse]
      def revoke_channel_token(access_token)
        payload = URI.encode_www_form(access_token: access_token)

        request = Request.new do |config|
          config.httpclient    = httpclient
          config.endpoint      = endpoint
          config.endpoint_path = '/oauth/revoke'
          config.content_type  = 'application/x-www-form-urlencoded'
          config.payload       = payload
        end

        request.post
      end

      # Push messages to line server and to user.
      #
      # @param user_id [String] User's identifiers
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def push_message(user_id, messages)
        channel_token_required

        messages = [messages] if messages.is_a?(Hash)

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/bot/message/push'
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
        channel_token_required

        messages = [messages] if messages.is_a?(Hash)

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/bot/message/reply'
          config.credentials    = credentials
          config.reply_token    = token
          config.messages       = messages
        end

        request.post
      end

      # Multicast messages to line server and to users.
      #
      # @param to [Array or String]
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def multicast(to, messages)
        channel_token_required

        to = [to] if to.is_a?(String)
        messages = [messages] if messages.is_a?(Hash)

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/bot/message/multicast'
          config.credentials    = credentials
          config.to             = to
          config.messages       = messages
        end

        request.post
      end

      # Broadcast messages to users
      #
      # @param messages [Hash or Array]
      #
      # @return [Net::HTTPResponse]
      def broadcast(messages)
        channel_token_required

        messages = [messages] if messages.is_a?(Hash)

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/bot/message/broadcast'
          config.credentials    = credentials
          config.messages       = messages
        end

        request.post
      end

      def leave_group(group_id)
        channel_token_required

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = "/bot/group/#{group_id}/leave"
          config.credentials    = credentials
        end

        request.post
      end

      def leave_room(room_id)
        channel_token_required

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = "/bot/room/#{room_id}/leave"
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
        endpoint_path  = "/bot/message/#{identifier}/content"
        get(endpoint_path)
      end

      # Get an user's profile.
      #
      # @param user_id [String] User's identifier
      #
      # @return [Net::HTTPResponse]
      def get_profile(user_id)
        endpoint_path  = "/bot/profile/#{user_id}"
        get(endpoint_path)
      end

      # Get an user's profile of a group.
      #
      # @param group_id [String] Group's identifier
      # @param user_id [String] User's identifier
      #
      # @return [Net::HTTPResponse]
      def get_group_member_profile(group_id, user_id)
        endpoint_path = "/bot/group/#{group_id}/member/#{user_id}"
        get(endpoint_path)
      end

      # Get an user's profile of a room.
      #
      # @param room_id [String] Room's identifier
      # @param user_id [String] User's identifier
      #
      # @return [Net::HTTPResponse]
      def get_room_member_profile(room_id, user_id)
        endpoint_path = "/bot/room/#{room_id}/member/#{user_id}"
        get(endpoint_path)
      end

      # Get user IDs of a group
      #
      # @param group_id [String] Group's identifier
      # @param continuation_token [String] Identifier to return next page
      #                                   (next property to be included in the response)
      #
      # @return [Net::HTTPResponse]
      def get_group_member_ids(group_id, continuation_token = nil)
        endpoint_path  = "/bot/group/#{group_id}/members/ids"
        endpoint_path += "?start=#{continuation_token}" if continuation_token
        get(endpoint_path)
      end

      # Get user IDs of a room
      #
      # @param group_id [String] Room's identifier
      # @param continuation_token [String] Identifier to return next page
      #                                   (next property to be included in the response)
      #
      # @return [Net::HTTPResponse]
      def get_room_member_ids(room_id, continuation_token = nil)
        endpoint_path  = "/bot/room/#{room_id}/members/ids"
        endpoint_path += "?start=#{continuation_token}" if continuation_token
        get(endpoint_path)
      end

      # Get a list of all uploaded rich menus
      #
      # @return [Net::HTTPResponse]
      def get_rich_menus
        endpoint_path = '/bot/richmenu/list'
        get(endpoint_path)
      end

      # Get a rich menu via a rich menu ID
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def get_rich_menu(rich_menu_id)
        endpoint_path = "/bot/richmenu/#{rich_menu_id}"
        get(endpoint_path)
      end

      # Gets the number of messages sent with the /bot/message/reply endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_reply(date)
        endpoint_path = "/bot/message/delivery/reply?date=#{date}"
        get(endpoint_path)
      end

      # Gets the number of messages sent with the /bot/message/push endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_push(date)
        endpoint_path = "/bot/message/delivery/push?date=#{date}"
        get(endpoint_path)
      end

      # Gets the number of messages sent with the /bot/message/multicast endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_multicast(date)
        endpoint_path = "/bot/message/delivery/multicast?date=#{date}"
        get(endpoint_path)
      end

      # Gets the number of messages sent with the /bot/message/multicast endpoint.
      #
      # @param date [String] Date the messages were sent (format: yyyyMMdd)
      #
      # @return [Net::HTTPResponse]
      def get_message_delivery_broadcast(date)
        endpoint_path = "/bot/message/delivery/broadcast?date=#{date}"
        get(endpoint_path)
      end

      # Create a rich menu
      #
      # @param rich_menu [Hash] The rich menu represented as a rich menu object
      #
      # @return [Net::HTTPResponse]
      def create_rich_menu(rich_menu)
        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = '/bot/richmenu'
          config.credentials    = credentials
          config.payload        = rich_menu.to_json
        end

        request.post
      end

      # Delete a rich menu
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def delete_rich_menu(rich_menu_id)
        endpoint_path = "/bot/richmenu/#{rich_menu_id}"
        delete(endpoint_path)
      end

      # Get the ID of the rich menu linked to a user
      #
      # @param user_id [String] ID of the user
      #
      # @return [Net::HTTPResponse]
      def get_user_rich_menu(user_id)
        endpoint_path = "/bot/user/#{user_id}/richmenu"
        get(endpoint_path)
      end

      # Get default rich menu
      #
      # @return [Net::HTTPResponse]
      def get_default_rich_menu
        endpoint_path = '/bot/user/all/richmenu'
        get(endpoint_path)
      end

      # Set default rich menu (Link a rich menu to all user)
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def set_default_rich_menu(rich_menu_id)
        endpoint_path = "/bot/user/all/richmenu/#{rich_menu_id}"
        post(endpoint_path)
      end

      # Unset default rich menu (Unlink a rich menu from all user)
      #
      # @return [Net::HTTPResponse]
      def unset_default_rich_menu
        endpoint_path = "/bot/user/all/richmenu"
        delete(endpoint_path)
      end

      # Link a rich menu to a user
      #
      # @param user_id [String] ID of the user
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def link_user_rich_menu(user_id, rich_menu_id)
        request = Request.new do |config|
          config.httpclient = httpclient
          config.endpoint = endpoint
          config.endpoint_path = "/bot/user/#{user_id}/richmenu/#{rich_menu_id}"
          config.credentials = credentials
        end

        request.post
      end

      # Unlink a rich menu from a user
      #
      # @param user_id [String] ID of the user
      #
      # @return [Net::HTTPResponse]
      def unlink_user_rich_menu(user_id)
        endpoint_path  = "/bot/user/#{user_id}/richmenu"
        delete(endpoint_path)
      end

      # To link a rich menu to multiple users at a time
      #
      # @param user_ids [Array] ID of the user
      # @param rich_menu_id [String] ID of the uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def bulk_link_rich_menus(user_ids, rich_menu_id)
        post("/bot/richmenu/bulk/link", {richMenuId: rich_menu_id, userIds: user_ids}.to_json)
      end

      # To unlink a rich menu from multiple users at a time
      #
      # @param user_ids [Array] ID of the user
      #
      # @return [Net::HTTPResponse]
      def bulk_unlink_rich_menus(user_ids)
        post("/bot/richmenu/bulk/unlink", {userIds: user_ids}.to_json)
      end

      # Download an image associated with a rich menu
      #
      # @param rich_menu_id [String] ID of an uploaded rich menu
      #
      # @return [Net::HTTPResponse]
      def get_rich_menu_image(rich_menu_id)
        endpoint_path = "/bot/richmenu/#{rich_menu_id}/content"
        get(endpoint_path)
      end

      # Upload and attaches an image to a rich menu
      #
      # @param rich_menu_id [String] The ID of the rich menu to attach the image to
      # @param file [File] Image file to attach rich menu
      #
      # @return [Net::HTTPResponse]
      def create_rich_menu_image(rich_menu_id, file)
        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = "/bot/richmenu/#{rich_menu_id}/content"
          config.credentials = credentials
          config.file = file
        end

        request.post
      end

      # Issue a link token to a user
      #
      # @param user_id [String] ID of the user
      #
      # @return [Net::HTTPResponse]
      def create_link_token(user_id)
        endpoint_path = "/bot/user/#{user_id}/linkToken"
        post(endpoint_path)
      end

      # Get the target limit for additional messages
      #
      # @return [Net::HTTPResponse]
      def get_quota
        endpoint_path = "/bot/message/quota"
        get(endpoint_path)
      end

      # Get number of messages sent this month
      #
      # @return [Net::HTTPResponse]
      def get_quota_consumption
        endpoint_path = "/bot/message/quota/consumption"
        get(endpoint_path)
      end

      # Fetch data, get content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def get(endpoint_path)
        channel_token_required

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = endpoint_path
          config.credentials    = credentials
        end

        request.get
      end

      # Post data, get content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def post(endpoint_path, payload = nil)
        channel_token_required

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = endpoint_path
          config.credentials    = credentials
          config.payload        = payload if payload
        end

        request.post
      end

      # Delete content of specified URL.
      #
      # @param endpoint_path [String]
      #
      # @return [Net::HTTPResponse]
      def delete(endpoint_path)
        channel_token_required

        request = Request.new do |config|
          config.httpclient     = httpclient
          config.endpoint       = endpoint
          config.endpoint_path  = endpoint_path
          config.credentials    = credentials
        end

        request.delete
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

      def channel_token_required
        raise ArgumentError, '`channel_token` is not configured' unless channel_token
      end

      def channel_id_required
        raise ArgumentError, '`channel_id` is not configured' unless channel_id
      end

      def channel_secret_required
        raise ArgumentError, '`channel_secret` is not configured' unless channel_secret
      end
    end
  end
end
