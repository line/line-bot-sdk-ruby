require 'line/bot/api/version'
require 'json'
require 'net/http'
require 'uri'

module Line
  module Bot
    class HTTPClient

      # @return [Net::HTTP]
      def http(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == "https"
          http.use_ssl = true
        end

        http
      end

      def get(url, header = {})
        uri = URI(url)
        http(uri).get(uri.request_uri, header)
      end

      def post(url, payload, header = {})
        uri = URI(url)
        http(uri).post(uri.request_uri, payload, header)
      end
    end
  end
end
