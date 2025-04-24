require 'net/http'
require 'uri'
require 'json'
require 'net/http/post/multipart'
require 'line/bot/version'

module Line
  module Bot
    module V2
      # This class is not intended for line-bot-sdk-ruby users. Breaking changes may occur; use at your own risk.

      class HttpClient
        # Initializes a new HttpClient instance.
        #
        # @param base_url [String] The base URL for requests.
        # @param http_headers [Hash] The default HTTP headers.
        # @param http_options [Hash] The HTTP options (same as Net::HTTP options).
        # https://docs.ruby-lang.org/en/3.4/Net/HTTP.html#method-i-options
        #
        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def initialize(base_url:, http_headers: {}, http_options: {})
          @base_url = base_url
          @http_headers = { 'User-Agent': "LINE-BotSDK-Ruby/#{Line::Bot::VERSION}" }.merge(normalize_headers(headers: http_headers))
          @http_options = http_options
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def get(path:, query_params: nil, headers: nil)
          request = build_request(http_class: Net::HTTP::Get, path: path, query_params: query_params, headers: headers)
          perform_request(request: request)
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def post(path:, query_params: nil, body_params: nil, headers: nil)
          request = build_request(http_class: Net::HTTP::Post, path: path, query_params: query_params, headers: headers, body_params: body_params)
          perform_request(request: request)
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def put(path:, query_params: nil, body_params: nil, headers: nil)
          request = build_request(http_class: Net::HTTP::Put, path: path, query_params: query_params, headers: headers, body_params: body_params)
          perform_request(request: request)
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def delete(path:, query_params: nil, headers: nil)
          request = build_request(http_class: Net::HTTP::Delete, path: path, query_params: query_params, headers: headers)
          perform_request(request: request)
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def post_form(path:, query_params: nil, form_params: nil, headers: nil)
          request = build_form_request(http_class: Net::HTTP::Post, path: path, query_params: query_params, form_params: form_params, headers: headers)
          perform_request(request: request)
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def post_form_multipart(path:, query_params: nil, form_params: nil, headers: nil)
          request = build_multipart_request(http_class: Net::HTTP::Post::Multipart, path: path, query_params: query_params, form_params: form_params, headers: headers)
          perform_request(request: request)
        end

        # NOTE: line-bot-sdk-ruby users should not use this. Breaking changes may occur, so use at your own risk.
        def put_form_multipart(path:, query_params: nil, form_params: nil, headers: nil)
          request = build_multipart_request(http_class: Net::HTTP::Put::Multipart, path: path, query_params: query_params, form_params: form_params, headers: headers)
          perform_request(request: request)
        end

        private

        def build_request(http_class:, path:, query_params:, headers:, body_params: nil)
          request_url = build_url(path: path, query_params: query_params)
          request_headers = build_headers(headers: headers)
          request = http_class.new(request_url, request_headers)

          if body_params
            if body_params.is_a?(File)
              request['Content-Type'] = determine_content_type(file: body_params)
              request.body = body_params.read
            else
              request['Content-Type'] = 'application/json'
              request.body = Line::Bot::V2::Utils.deep_compact(
                Line::Bot::V2::Utils.deep_camelize(
                  Line::Bot::V2::Utils.deep_to_hash(body_params)
                )
              ).to_json
            end
          end

          request
        end

        def build_form_request(http_class:, path:, query_params:, form_params:, headers:)
          request_url = build_url(path: path, query_params: query_params)
          request_headers = build_headers(headers: headers)
          request = http_class.new(request_url, request_headers)

          if form_params
            request['Content-Type'] = 'application/x-www-form-urlencoded'
            request.body = URI.encode_www_form(Line::Bot::V2::Utils.deep_to_hash(form_params))
          end

          request
        end

        def build_multipart_request(http_class:, path:, query_params:, form_params:, headers:)
          request_url = build_url(path: path, query_params: query_params)
          request_headers = build_headers(headers: headers)

          file_params, non_file_params = form_params.partition { |_, value| value.is_a?(File) }.map(&:to_h) # steep:ignore NoMethod
          params = Line::Bot::V2::Utils.deep_to_hash(non_file_params).merge(
            file_params.transform_values { |value| UploadIO.new(value, 'text/plain', File.basename(value.path)) }
          )

          http_class.new(request_url, params, request_headers)
        end

        def build_url(path:, query_params:)
          uri = URI.join(@base_url, path)
          uri.query = URI.encode_www_form(query_params) unless query_params.nil?
          uri
        end

        def build_headers(headers: nil)
          return @http_headers if headers.nil?

          @http_headers.merge(normalize_headers(headers: headers))
        end

        def perform_request(request:)
          Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: request.uri.scheme == 'https') do |http| # steep:ignore ArgumentTypeMismatch
            @http_options.each do |key, value|
              http.send("#{key}=", value)
            end if @http_options

            http.request(request)
          end
        end

        def determine_content_type(file:)
          case File.extname(path=file.path).downcase
          when '.txt'
            'text/plain'
          when '.jpg', '.jpeg'
            'image/jpeg'
          when '.png'
            'image/png'
          when '.gif'
            'image/gif'
          else
            'application/octet-stream'
          end
        end

        def normalize_headers(headers:)
          return {} if headers.nil?

          headers
            .transform_keys(&:to_sym)
            .transform_values(&:to_s)
        end
      end
    end
  end
end
