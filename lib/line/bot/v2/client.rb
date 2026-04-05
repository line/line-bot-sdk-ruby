# This file is intended for manual edits.
#
# Generated delegation methods live in ./client.generated.rb.
# Generated factory helpers live in ./client.factory.generated.rb.

require 'line/bot/v2/insight/core'
require 'line/bot/v2/liff/core'
require 'line/bot/v2/manage_audience/core'
require 'line/bot/v2/messaging_api/core'
require 'line/bot/v2/module/core'
require 'line/bot/v2/shop/core'
require 'line/bot/v2/client.generated'
require 'line/bot/v2/client.factory.generated'

module Line
  module Bot
    module V2
      # A single client for all LINE Bot APIs, except channel access token and module attach management.
      #
      # It wraps the individual generated API clients and exposes their methods directly,
      # so callers can work with one object instead of juggling several client instances.
      #
      # For channel access token operations, use {Line::Bot::V2::ChannelAccessToken::ApiClient} directly.
      # For module attach operations, use {Line::Bot::V2::ModuleAttach::ApiClient} directly.
      class Client
        # @param channel_access_token [String] Channel access token issued for your LINE Official Account.
        # @param api_base_url [String, nil] Base URL for Messaging API style endpoints. Defaults to https://api.line.me.
        # @param data_api_base_url [String, nil] Base URL for data/blob endpoints. Defaults to https://api-data.line.me.
        # @param http_options [Hash{String|Symbol => untyped}] Net::HTTP options passed to all generated clients.
        def initialize(
          channel_access_token:,
          api_base_url: nil,
          data_api_base_url: nil,
          http_options: {}
        )
          unless channel_access_token.is_a?(String) && !channel_access_token.empty?
            raise TypeError, 'channel_access_token must be a non-empty String.'
          end

          build_generated_delegates(
            channel_access_token: channel_access_token,
            api_base_url: api_base_url,
            data_api_base_url: data_api_base_url,
            http_options: http_options
          )
        end
      end
    end
  end
end
