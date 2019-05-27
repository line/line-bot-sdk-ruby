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
    class HttpClient
      JSON_HEADER = {'Content-Type' => 'application/json; charset=UTF-8'}
      FORM_HEADER = {'Content-Type' => 'application/x-www-form-urlencoded'}

      attr_accessor :http_options, :default_headers

      def initialize(options = {})
        options.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
        yield(self) if block_given?
      end

      # advanced methods
      def post_json(url, json, query: {}, header: {})
        json = json.to_json unless json.is_a?(String)
        header = JSON_HEADER.merge(header)
        post(url, json, query: query, header: header)
      end

      def post_form(url, form, query: {}, header: {})
        body = URI.encode_www_form(form)
        header = FORM_HEADER.merge(header)
        post(url, body, query: query, header: header)
      end

      def post_file(url, file, query: {}, header: {})
        content_type = case file.path
          when /\.png\z/i then 'image/png'
          when /\.jpe?g\z/i then 'image/jpeg'
          else
            raise ArgumentError.new("invalid file extension: #{file.path}")
        end
        header = {'Content-Type' => content_type}.merge(header)
        body = file.seek(0) && file.read
        post(url, body, query: query, header: header)
      end

      # primitive methods
      def get(url, query: {}, header: {})
        req = Net::HTTP::Get.new(uri_with_query(url, query))
        http(req, header)
      end

      def delete(url, query: {}, header: {})
        req = Net::HTTP::Delete.new(uri_with_query(url, query))
        http(req, header)
      end

      def post(url, body, query: {}, header: {})
        req = Net::HTTP::Post.new(uri_with_query(url, query))
        req.body = body
        http(req, header)
      end

      private

      def uri_with_query(url, query)
        uri = URI(url)
        uri.query = URI.encode_www_form(query)
        uri
      end

      def http(req, header)
        default_headers.merge(header).each do |key, val|
          req[key.to_s] = val.to_s
        end
        uri = req.uri
        http = Net::HTTP.new(uri.host, uri.port)

        if uri.scheme == "https"
          http.use_ssl = true
        end

        if http_options
          http_options.each do |key, value|
            http.send("#{key}=", value)
          end
        end

        http.request(req)
      end
    end
  end
end
