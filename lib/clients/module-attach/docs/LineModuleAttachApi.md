# LINE::Client::ModuleAttach::LineModuleAttachApi

All URIs are relative to *https://manager.line.biz*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**attach_module**](LineModuleAttachApi.md#attach_module) | **POST** /module/auth/v1/token |  |


## attach_module

> <AttachModuleResponse> attach_module(opts)



Attach by operation of the module channel provider

### Examples

```ruby
require 'time'
require 'line_client_module_attach'
# setup authorization
LINE::Client::ModuleAttach.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = LINE::Client::ModuleAttach::LineModuleAttachApi.new
opts = {
  grant_type: 'grant_type_example', # String | authorization_code
  code: 'code_example', # String | Authorization code received from the LINE Platform.
  redirect_uri: 'redirect_uri_example', # String | Specify the redirect_uri specified in the URL for authentication and authorization.
  code_verifier: 'code_verifier_example', # String | Specify when using PKCE (Proof Key for Code Exchange) defined in the OAuth 2.0 extension specification as a countermeasure against authorization code interception attacks.
  client_id: 'client_id_example', # String | Instead of using Authorization header, you can use this parameter to specify the channel ID of the module channel. You can find the channel ID of the module channel in the LINE Developers Console. 
  client_secret: 'client_secret_example', # String | Instead of using Authorization header, you can use this parameter to specify the channel secret of the module channel. You can find the channel secret of the module channel in the LINE Developers Console. 
  region: 'region_example', # String | If you specified a value for region in the URL for authentication and authorization, specify the same value. 
  basic_search_id: 'basic_search_id_example', # String | If you specified a value for basic_search_id in the URL for authentication and authorization, specify the same value.
  scope: 'scope_example', # String | If you specified a value for scope in the URL for authentication and authorization, specify the same value.
  brand_type: 'brand_type_example' # String | If you specified a value for brand_type in the URL for authentication and authorization, specify the same value.
}

begin
  
  result = api_instance.attach_module(opts)
  p result
rescue LINE::Client::ModuleAttach::ApiError => e
  puts "Error when calling LineModuleAttachApi->attach_module: #{e}"
end
```

#### Using the attach_module_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AttachModuleResponse>, Integer, Hash)> attach_module_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.attach_module_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AttachModuleResponse>
rescue LINE::Client::ModuleAttach::ApiError => e
  puts "Error when calling LineModuleAttachApi->attach_module_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **grant_type** | **String** | authorization_code | [optional] |
| **code** | **String** | Authorization code received from the LINE Platform. | [optional] |
| **redirect_uri** | **String** | Specify the redirect_uri specified in the URL for authentication and authorization. | [optional] |
| **code_verifier** | **String** | Specify when using PKCE (Proof Key for Code Exchange) defined in the OAuth 2.0 extension specification as a countermeasure against authorization code interception attacks. | [optional] |
| **client_id** | **String** | Instead of using Authorization header, you can use this parameter to specify the channel ID of the module channel. You can find the channel ID of the module channel in the LINE Developers Console.  | [optional] |
| **client_secret** | **String** | Instead of using Authorization header, you can use this parameter to specify the channel secret of the module channel. You can find the channel secret of the module channel in the LINE Developers Console.  | [optional] |
| **region** | **String** | If you specified a value for region in the URL for authentication and authorization, specify the same value.  | [optional] |
| **basic_search_id** | **String** | If you specified a value for basic_search_id in the URL for authentication and authorization, specify the same value. | [optional] |
| **scope** | **String** | If you specified a value for scope in the URL for authentication and authorization, specify the same value. | [optional] |
| **brand_type** | **String** | If you specified a value for brand_type in the URL for authentication and authorization, specify the same value. | [optional] |

### Return type

[**AttachModuleResponse**](AttachModuleResponse.md)

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: application/json

