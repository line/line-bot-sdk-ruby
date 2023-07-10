# LINE::Client::Shop::ShopApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**mission_sticker_v3**](ShopApi.md#mission_sticker_v3) | **POST** /shop/v3/mission |  |


## mission_sticker_v3

> mission_sticker_v3(mission_sticker_request)



Sends a mission sticker.

### Examples

```ruby
require 'time'
require 'line_client_shop'
# setup authorization
LINE::Client::Shop.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Shop::ShopApi.new
mission_sticker_request = LINE::Client::Shop::MissionStickerRequest.new({to: 'to_example', product_id: 'product_id_example', product_type: 'STICKER', send_present_message: false}) # MissionStickerRequest | 

begin
  
  api_instance.mission_sticker_v3(mission_sticker_request)
rescue LINE::Client::Shop::ApiError => e
  puts "Error when calling ShopApi->mission_sticker_v3: #{e}"
end
```

#### Using the mission_sticker_v3_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> mission_sticker_v3_with_http_info(mission_sticker_request)

```ruby
begin
  
  data, status_code, headers = api_instance.mission_sticker_v3_with_http_info(mission_sticker_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::Shop::ApiError => e
  puts "Error when calling ShopApi->mission_sticker_v3_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **mission_sticker_request** | [**MissionStickerRequest**](MissionStickerRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

