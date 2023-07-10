=begin
#Mission Stickers API

#This document describes LINE Mission Stickers API.

The version of the OpenAPI document: 0.0.1

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.6.0

=end

require 'cgi'

module LINE::Client::Shop
  class ShopApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Sends a mission sticker.
    # @param mission_sticker_request [MissionStickerRequest] 
    # @param [Hash] opts the optional parameters
    # @return [nil]
    def mission_sticker_v3(mission_sticker_request, opts = {})
      mission_sticker_v3_with_http_info(mission_sticker_request, opts)
      nil
    end

    # Sends a mission sticker.
    # @param mission_sticker_request [MissionStickerRequest] 
    # @param [Hash] opts the optional parameters
    # @return [Array<(nil, Integer, Hash)>] nil, response status code and response headers
    def mission_sticker_v3_with_http_info(mission_sticker_request, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: ShopApi.mission_sticker_v3 ...'
      end
      # verify the required parameter 'mission_sticker_request' is set
      if @api_client.config.client_side_validation && mission_sticker_request.nil?
        fail ArgumentError, "Missing the required parameter 'mission_sticker_request' when calling ShopApi.mission_sticker_v3"
      end
      # resource path
      local_var_path = '/shop/v3/mission'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Content-Type'
      content_type = @api_client.select_header_content_type(['application/json'])
      if !content_type.nil?
          header_params['Content-Type'] = content_type
      end

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body] || @api_client.object_to_http_body(mission_sticker_request)

      # return_type
      return_type = opts[:debug_return_type]

      # auth_names
      auth_names = opts[:debug_auth_names] || ['Bearer']

      new_options = opts.merge(
        :operation => :"ShopApi.mission_sticker_v3",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: ShopApi#mission_sticker_v3\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
