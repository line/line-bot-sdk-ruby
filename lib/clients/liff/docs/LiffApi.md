# LINE::Client::Liff::LiffApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**add_liff_app**](LiffApi.md#add_liff_app) | **POST** /liff/v1/apps |  |
| [**delete_liff_app**](LiffApi.md#delete_liff_app) | **DELETE** /liff/v1/apps/{liffId} | Delete LIFF app from a channel |
| [**get_all_liff_apps**](LiffApi.md#get_all_liff_apps) | **GET** /liff/v1/apps | Get all LIFF apps |
| [**update_liff_app**](LiffApi.md#update_liff_app) | **PUT** /liff/v1/apps/{liffId} |  |


## add_liff_app

> <AddLiffAppResponse> add_liff_app(add_liff_app_request)



Adding the LIFF app to a channel

### Examples

```ruby
require 'time'
require 'line_client_liff'
# setup authorization
LINE::Client::Liff.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Liff::LiffApi.new
add_liff_app_request = LINE::Client::Liff::AddLiffAppRequest.new({view: LINE::Client::Liff::LiffView.new({type: 'compact', url: 'url_example'})}) # AddLiffAppRequest | 

begin
  
  result = api_instance.add_liff_app(add_liff_app_request)
  p result
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->add_liff_app: #{e}"
end
```

#### Using the add_liff_app_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AddLiffAppResponse>, Integer, Hash)> add_liff_app_with_http_info(add_liff_app_request)

```ruby
begin
  
  data, status_code, headers = api_instance.add_liff_app_with_http_info(add_liff_app_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AddLiffAppResponse>
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->add_liff_app_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **add_liff_app_request** | [**AddLiffAppRequest**](AddLiffAppRequest.md) |  |  |

### Return type

[**AddLiffAppResponse**](AddLiffAppResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_liff_app

> delete_liff_app(liff_id)

Delete LIFF app from a channel

Deletes a LIFF app from a channel. 

### Examples

```ruby
require 'time'
require 'line_client_liff'
# setup authorization
LINE::Client::Liff.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Liff::LiffApi.new
liff_id = 'liff_id_example' # String | ID of the LIFF app to be updated

begin
  # Delete LIFF app from a channel
  api_instance.delete_liff_app(liff_id)
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->delete_liff_app: #{e}"
end
```

#### Using the delete_liff_app_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_liff_app_with_http_info(liff_id)

```ruby
begin
  # Delete LIFF app from a channel
  data, status_code, headers = api_instance.delete_liff_app_with_http_info(liff_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->delete_liff_app_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **liff_id** | **String** | ID of the LIFF app to be updated |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## get_all_liff_apps

> <GetAllLiffAppsResponse> get_all_liff_apps

Get all LIFF apps

Gets information on all the LIFF apps added to the channel.

### Examples

```ruby
require 'time'
require 'line_client_liff'
# setup authorization
LINE::Client::Liff.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Liff::LiffApi.new

begin
  # Get all LIFF apps
  result = api_instance.get_all_liff_apps
  p result
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->get_all_liff_apps: #{e}"
end
```

#### Using the get_all_liff_apps_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAllLiffAppsResponse>, Integer, Hash)> get_all_liff_apps_with_http_info

```ruby
begin
  # Get all LIFF apps
  data, status_code, headers = api_instance.get_all_liff_apps_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAllLiffAppsResponse>
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->get_all_liff_apps_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetAllLiffAppsResponse**](GetAllLiffAppsResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_liff_app

> update_liff_app(liff_id, update_liff_app_request)



Update LIFF app settings

### Examples

```ruby
require 'time'
require 'line_client_liff'
# setup authorization
LINE::Client::Liff.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Liff::LiffApi.new
liff_id = 'liff_id_example' # String | ID of the LIFF app to be updated
update_liff_app_request = LINE::Client::Liff::UpdateLiffAppRequest.new # UpdateLiffAppRequest | 

begin
  
  api_instance.update_liff_app(liff_id, update_liff_app_request)
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->update_liff_app: #{e}"
end
```

#### Using the update_liff_app_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> update_liff_app_with_http_info(liff_id, update_liff_app_request)

```ruby
begin
  
  data, status_code, headers = api_instance.update_liff_app_with_http_info(liff_id, update_liff_app_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::Liff::ApiError => e
  puts "Error when calling LiffApi->update_liff_app_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **liff_id** | **String** | ID of the LIFF app to be updated |  |
| **update_liff_app_request** | [**UpdateLiffAppRequest**](UpdateLiffAppRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

