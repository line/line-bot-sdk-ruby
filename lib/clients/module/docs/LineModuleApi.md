# LINE::Client::Module::LineModuleApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**acquire_chat_control**](LineModuleApi.md#acquire_chat_control) | **POST** /v2/bot/chat/{chatId}/control/acquire |  |
| [**detach_module**](LineModuleApi.md#detach_module) | **POST** /v2/bot/channel/detach |  |
| [**get_modules**](LineModuleApi.md#get_modules) | **GET** /v2/bot/list |  |
| [**release_chat_control**](LineModuleApi.md#release_chat_control) | **POST** /v2/bot/chat/{chatId}/control/release |  |


## acquire_chat_control

> acquire_chat_control(chat_id, opts)



If the Standby Channel wants to take the initiative (Chat Control), it calls the Acquire Control API. The channel that was previously an Active Channel will automatically switch to a Standby Channel. 

### Examples

```ruby
require 'time'
require 'line_client_module'
# setup authorization
LINE::Client::Module.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Module::LineModuleApi.new
chat_id = 'chat_id_example' # String | The `userId`, `roomId`, or `groupId`
opts = {
  acquire_chat_control_request: LINE::Client::Module::AcquireChatControlRequest.new # AcquireChatControlRequest | 
}

begin
  
  api_instance.acquire_chat_control(chat_id, opts)
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->acquire_chat_control: #{e}"
end
```

#### Using the acquire_chat_control_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> acquire_chat_control_with_http_info(chat_id, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.acquire_chat_control_with_http_info(chat_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->acquire_chat_control_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **chat_id** | **String** | The &#x60;userId&#x60;, &#x60;roomId&#x60;, or &#x60;groupId&#x60; |  |
| **acquire_chat_control_request** | [**AcquireChatControlRequest**](AcquireChatControlRequest.md) |  | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## detach_module

> detach_module(opts)



The module channel admin calls the Detach API to detach the module channel from a LINE Official Account.

### Examples

```ruby
require 'time'
require 'line_client_module'
# setup authorization
LINE::Client::Module.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Module::LineModuleApi.new
opts = {
  detach_module_request: LINE::Client::Module::DetachModuleRequest.new # DetachModuleRequest | 
}

begin
  
  api_instance.detach_module(opts)
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->detach_module: #{e}"
end
```

#### Using the detach_module_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> detach_module_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.detach_module_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->detach_module_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **detach_module_request** | [**DetachModuleRequest**](DetachModuleRequest.md) |  | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## get_modules

> <GetModulesResponse> get_modules(opts)



Gets a list of basic information about the bots of multiple LINE Official Accounts that have attached module channels.

### Examples

```ruby
require 'time'
require 'line_client_module'
# setup authorization
LINE::Client::Module.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Module::LineModuleApi.new
opts = {
  start: 'start_example', # String | Value of the continuation token found in the next property of the JSON object returned in the response. If you can't get all basic information about the bots in one request, include this parameter to get the remaining array. 
  limit: 56 # Integer | Specify the maximum number of bots that you get basic information from. The default value is 100. Max value: 100 
}

begin
  
  result = api_instance.get_modules(opts)
  p result
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->get_modules: #{e}"
end
```

#### Using the get_modules_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetModulesResponse>, Integer, Hash)> get_modules_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_modules_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetModulesResponse>
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->get_modules_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **start** | **String** | Value of the continuation token found in the next property of the JSON object returned in the response. If you can&#39;t get all basic information about the bots in one request, include this parameter to get the remaining array.  | [optional] |
| **limit** | **Integer** | Specify the maximum number of bots that you get basic information from. The default value is 100. Max value: 100  | [optional][default to 100] |

### Return type

[**GetModulesResponse**](GetModulesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## release_chat_control

> release_chat_control(chat_id)



To return the initiative (Chat Control) of Active Channel to Primary Channel, call the Release Control API. 

### Examples

```ruby
require 'time'
require 'line_client_module'
# setup authorization
LINE::Client::Module.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Module::LineModuleApi.new
chat_id = 'chat_id_example' # String | The `userId`, `roomId`, or `groupId`

begin
  
  api_instance.release_chat_control(chat_id)
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->release_chat_control: #{e}"
end
```

#### Using the release_chat_control_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> release_chat_control_with_http_info(chat_id)

```ruby
begin
  
  data, status_code, headers = api_instance.release_chat_control_with_http_info(chat_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::Module::ApiError => e
  puts "Error when calling LineModuleApi->release_chat_control_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **chat_id** | **String** | The &#x60;userId&#x60;, &#x60;roomId&#x60;, or &#x60;groupId&#x60; |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined

