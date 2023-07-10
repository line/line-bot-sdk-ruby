# LINE::Client::ChannelAccessToken::ChannelAccessTokenApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**gets_all_valid_channel_access_token_key_ids**](ChannelAccessTokenApi.md#gets_all_valid_channel_access_token_key_ids) | **GET** /oauth2/v2.1/tokens/kid |  |
| [**issue_channel_token**](ChannelAccessTokenApi.md#issue_channel_token) | **POST** /v2/oauth/accessToken |  |
| [**issue_channel_token_by_jwt**](ChannelAccessTokenApi.md#issue_channel_token_by_jwt) | **POST** /oauth2/v2.1/token |  |
| [**revoke_channel_token**](ChannelAccessTokenApi.md#revoke_channel_token) | **POST** /v2/oauth/revoke |  |
| [**revoke_channel_token_by_jwt**](ChannelAccessTokenApi.md#revoke_channel_token_by_jwt) | **POST** /oauth2/v2.1/revoke |  |
| [**verify_channel_token**](ChannelAccessTokenApi.md#verify_channel_token) | **POST** /v2/oauth/verify |  |
| [**verify_channel_token_by_jwt**](ChannelAccessTokenApi.md#verify_channel_token_by_jwt) | **GET** /oauth2/v2.1/verify |  |


## gets_all_valid_channel_access_token_key_ids

> <ChannelAccessTokenKeyIdsResponse> gets_all_valid_channel_access_token_key_ids(client_assertion_type, client_assertion)



Gets all valid channel access token key IDs.

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
client_assertion_type = 'client_assertion_type_example' # String | `urn:ietf:params:oauth:client-assertion-type:jwt-bearer`
client_assertion = 'client_assertion_example' # String | A JSON Web Token (JWT) (opens new window)the client needs to create and sign with the private key.

begin
  
  result = api_instance.gets_all_valid_channel_access_token_key_ids(client_assertion_type, client_assertion)
  p result
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->gets_all_valid_channel_access_token_key_ids: #{e}"
end
```

#### Using the gets_all_valid_channel_access_token_key_ids_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ChannelAccessTokenKeyIdsResponse>, Integer, Hash)> gets_all_valid_channel_access_token_key_ids_with_http_info(client_assertion_type, client_assertion)

```ruby
begin
  
  data, status_code, headers = api_instance.gets_all_valid_channel_access_token_key_ids_with_http_info(client_assertion_type, client_assertion)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ChannelAccessTokenKeyIdsResponse>
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->gets_all_valid_channel_access_token_key_ids_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **client_assertion_type** | **String** | &#x60;urn:ietf:params:oauth:client-assertion-type:jwt-bearer&#x60; |  |
| **client_assertion** | **String** | A JSON Web Token (JWT) (opens new window)the client needs to create and sign with the private key. |  |

### Return type

[**ChannelAccessTokenKeyIdsResponse**](ChannelAccessTokenKeyIdsResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## issue_channel_token

> <IssueShortLivedChannelAccessTokenResponse> issue_channel_token(opts)



Issue short-lived channel access token

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
opts = {
  grant_type: 'grant_type_example', # String | `client_credentials`
  client_id: 'client_id_example', # String | Channel ID.
  client_secret: 'client_secret_example' # String | Channel secret.
}

begin
  
  result = api_instance.issue_channel_token(opts)
  p result
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->issue_channel_token: #{e}"
end
```

#### Using the issue_channel_token_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<IssueShortLivedChannelAccessTokenResponse>, Integer, Hash)> issue_channel_token_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.issue_channel_token_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <IssueShortLivedChannelAccessTokenResponse>
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->issue_channel_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **grant_type** | **String** | &#x60;client_credentials&#x60; | [optional] |
| **client_id** | **String** | Channel ID. | [optional] |
| **client_secret** | **String** | Channel secret. | [optional] |

### Return type

[**IssueShortLivedChannelAccessTokenResponse**](IssueShortLivedChannelAccessTokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: application/json


## issue_channel_token_by_jwt

> <IssueChannelAccessTokenResponse> issue_channel_token_by_jwt(opts)



Issues a channel access token that allows you to specify a desired expiration date. This method lets you use JWT assertion for authentication.

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
opts = {
  grant_type: 'grant_type_example', # String | client_credentials
  client_assertion_type: 'client_assertion_type_example', # String | urn:ietf:params:oauth:client-assertion-type:jwt-bearer
  client_assertion: 'client_assertion_example' # String | A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key.
}

begin
  
  result = api_instance.issue_channel_token_by_jwt(opts)
  p result
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->issue_channel_token_by_jwt: #{e}"
end
```

#### Using the issue_channel_token_by_jwt_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<IssueChannelAccessTokenResponse>, Integer, Hash)> issue_channel_token_by_jwt_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.issue_channel_token_by_jwt_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <IssueChannelAccessTokenResponse>
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->issue_channel_token_by_jwt_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **grant_type** | **String** | client_credentials | [optional] |
| **client_assertion_type** | **String** | urn:ietf:params:oauth:client-assertion-type:jwt-bearer | [optional] |
| **client_assertion** | **String** | A JSON Web Token the client needs to create and sign with the private key of the Assertion Signing Key. | [optional] |

### Return type

[**IssueChannelAccessTokenResponse**](IssueChannelAccessTokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: application/json


## revoke_channel_token

> revoke_channel_token(opts)



Revoke short-lived or long-lived channel access token

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
opts = {
  access_token: 'access_token_example' # String | Channel access token
}

begin
  
  api_instance.revoke_channel_token(opts)
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->revoke_channel_token: #{e}"
end
```

#### Using the revoke_channel_token_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> revoke_channel_token_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.revoke_channel_token_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->revoke_channel_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | Channel access token | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: Not defined


## revoke_channel_token_by_jwt

> revoke_channel_token_by_jwt(opts)



Revoke channel access token v2.1

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
opts = {
  client_id: 'client_id_example', # String | Channel ID
  client_secret: 'client_secret_example', # String | Channel Secret
  access_token: 'access_token_example' # String | Channel access token
}

begin
  
  api_instance.revoke_channel_token_by_jwt(opts)
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->revoke_channel_token_by_jwt: #{e}"
end
```

#### Using the revoke_channel_token_by_jwt_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> revoke_channel_token_by_jwt_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.revoke_channel_token_by_jwt_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->revoke_channel_token_by_jwt_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **client_id** | **String** | Channel ID | [optional] |
| **client_secret** | **String** | Channel Secret | [optional] |
| **access_token** | **String** | Channel access token | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: Not defined


## verify_channel_token

> <VerifyChannelAccessTokenResponse> verify_channel_token(opts)



Verify the validity of short-lived and long-lived channel access tokens

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
opts = {
  access_token: 'access_token_example' # String | A short-lived or long-lived channel access token.
}

begin
  
  result = api_instance.verify_channel_token(opts)
  p result
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->verify_channel_token: #{e}"
end
```

#### Using the verify_channel_token_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<VerifyChannelAccessTokenResponse>, Integer, Hash)> verify_channel_token_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.verify_channel_token_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <VerifyChannelAccessTokenResponse>
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->verify_channel_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | A short-lived or long-lived channel access token. | [optional] |

### Return type

[**VerifyChannelAccessTokenResponse**](VerifyChannelAccessTokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: application/json


## verify_channel_token_by_jwt

> <VerifyChannelAccessTokenResponse> verify_channel_token_by_jwt(access_token)



You can verify whether a Channel access token with a user-specified expiration (Channel Access Token v2.1) is valid.

### Examples

```ruby
require 'time'
require 'line_client_channel_access_token'
# setup authorization
LINE::Client::ChannelAccessToken.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ChannelAccessToken::ChannelAccessTokenApi.new
access_token = 'access_token_example' # String | Channel access token with a user-specified expiration (Channel Access Token v2.1).

begin
  
  result = api_instance.verify_channel_token_by_jwt(access_token)
  p result
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->verify_channel_token_by_jwt: #{e}"
end
```

#### Using the verify_channel_token_by_jwt_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<VerifyChannelAccessTokenResponse>, Integer, Hash)> verify_channel_token_by_jwt_with_http_info(access_token)

```ruby
begin
  
  data, status_code, headers = api_instance.verify_channel_token_by_jwt_with_http_info(access_token)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <VerifyChannelAccessTokenResponse>
rescue LINE::Client::ChannelAccessToken::ApiError => e
  puts "Error when calling ChannelAccessTokenApi->verify_channel_token_by_jwt_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | Channel access token with a user-specified expiration (Channel Access Token v2.1). |  |

### Return type

[**VerifyChannelAccessTokenResponse**](VerifyChannelAccessTokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

