require 'net/http'
require 'uri'
require 'json'
require 'net/http/post/multipart'

module Line
  module Bot
    module V2
      class HttpClient
        def initialize(base_url:, http_headers: {}, http_options: {})
          @base_url = base_url
          @http_headers = { 'User-Agent' => "LINE-BotSDK-Ruby/#{Line::Bot::V2::VERSION}" }.merge(http_headers)
          @http_options = http_options
        end

        def get(path:, query_params: nil, headers: nil)
          request = build_request(Net::HTTP::Get, path, query_params, headers)
          perform_request(request)
        end

        def post(path:, query_params: nil, body_params: nil, headers: nil)
          request = build_request(Net::HTTP::Post, path, query_params, headers, body_params)
          perform_request(request)
        end

        def put(path:, query_params: nil, body_params: nil, headers: nil)
          request = build_request(Net::HTTP::Put, path, query_params, headers, body_params)
          perform_request(request)
        end

        def delete(path:, query_params: nil, headers: nil)
          request = build_request(Net::HTTP::Delete, path, query_params, headers)
          perform_request(request)
        end

        def post_form(path:, query_params: nil, form_params: nil, headers: nil)
          request = build_form_request(Net::HTTP::Post, path, query_params, form_params, headers)
          perform_request(request)
        end

        def post_form_multipart(path:, query_params: nil, form_params: nil, headers: nil)
          request = build_multipart_request(Net::HTTP::Post::Multipart, path, query_params, form_params, headers)
          perform_request(request)
        end

        def put_form_multipart(path:, query_params: nil, form_params: nil, headers: nil)
          request = build_multipart_request(Net::HTTP::Put::Multipart, path, query_params, form_params, headers)
          perform_request(request)
        end

        private

        def build_request(http_class, path, query_params, headers, body_params = nil)
          request_url = build_url(path, query_params)
          request_headers = build_headers(headers)
          request = http_class.new(request_url, request_headers)

          if body_params
            if body_params.is_a?(File)
              request['Content-Type'] = determine_content_type(body_params)
              request.body = body_params.read
            else
              request['Content-Type'] = 'application/json'
              request.body = deep_compact(deep_camelize(deep_to_hash(body_params))).to_json
            end
          end

          request
        end

        def build_form_request(http_class, path, query_params, form_params, headers)
          request_url = build_url(path, query_params)
          request_headers = build_headers(headers)
          request = http_class.new(request_url, request_headers)

          if form_params
            request['Content-Type'] = 'application/x-www-form-urlencoded'
            request.body = URI.encode_www_form(deep_to_hash(form_params))
          end

          request
        end

        def build_multipart_request(http_class, path, query_params, form_params, headers)
          request_url = build_url(path, query_params)
          request_headers = build_headers(headers)

          file_params, non_file_params = form_params.partition { |_, value| value.is_a?(File) }.map(&:to_h)
          params = deep_to_hash(non_file_params).merge(
            file_params.transform_values { |value| UploadIO.new(value, 'text/plain', File.basename(value.path)) }
          )

          http_class.new(request_url, params, request_headers)
        end

        def build_url(path, query_params)
          uri = URI.join(@base_url, path)
          uri.query = URI.encode_www_form(query_params) unless query_params.nil?
          uri
        end

        def build_headers(headers = nil)
          headers.nil? ? @http_headers : @http_headers.merge(headers)
        end

        def perform_request(request)
          Net::HTTP.start(request.uri.hostname, request.uri.port, use_ssl: request.uri.scheme == 'https') do |http|
            @http_options.each do |key, value|
              http.send("#{key}=", value)
            end if @http_options

            http.request(request)
          end
        end

        def determine_content_type(file)
          case File.extname(file.path).downcase
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

        def deep_to_hash(object)
          if object.is_a?(Array)
            object.map { |item| deep_to_hash(item) }
          elsif object.is_a?(Hash)
            object.
              transform_keys { |k| camelize(k) }.
              transform_values { |v| deep_to_hash(v) }
          elsif object.instance_variables.empty?
            object
          else
            object.instance_variables.each_with_object({}) do |var, hash|
              value = object.instance_variable_get(var)
              key = camelize(var.to_s.delete('@')).to_sym
              hash[key] = deep_to_hash(value)
            end
          end
        end

        def deep_camelize(hash)
          return hash unless hash.is_a?(Hash)

          hash.each_with_object({}) do |(k, v), new_hash|
            camel_key = camelize(k).to_sym
            new_value = v.is_a?(Hash) ? deep_camelize(v) : v
            new_hash[camel_key] = new_value
          end
        end

        def deep_compact(object)
          case object
          when Hash
            object.each_with_object({}) do |(k, v), new_hash|
              new_value = deep_compact(v)
              new_hash[k] = new_value unless new_value.nil? || (new_value.respond_to?(:empty?) && new_value.empty?)
            end
          when Array
            object.map { |item| deep_compact(item) }.compact
          else
            object
          end
        end

        def camelize(str)
          str.to_s.split('_').inject { |memo, word| memo + word.capitalize }
        end
      end
    end
  end
end
