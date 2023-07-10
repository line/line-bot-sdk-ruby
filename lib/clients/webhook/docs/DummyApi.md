# LINE::Client::Webhook::DummyApi

All URIs are relative to *https://example.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**callback**](DummyApi.md#callback) | **POST** /callback |  |


## callback

> String callback(callback_request)



This is the dummy endpoint to generate the model classes

### Examples

```ruby
require 'time'
require 'line_client_webhook'

api_instance = LINE::Client::Webhook::DummyApi.new
callback_request = LINE::Client::Webhook::CallbackRequest.new # CallbackRequest | 

begin
  
  result = api_instance.callback(callback_request)
  p result
rescue LINE::Client::Webhook::ApiError => e
  puts "Error when calling DummyApi->callback: #{e}"
end
```

#### Using the callback_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(String, Integer, Hash)> callback_with_http_info(callback_request)

```ruby
begin
  
  data, status_code, headers = api_instance.callback_with_http_info(callback_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => String
rescue LINE::Client::Webhook::ApiError => e
  puts "Error when calling DummyApi->callback_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **callback_request** | [**CallbackRequest**](CallbackRequest.md) |  |  |

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

