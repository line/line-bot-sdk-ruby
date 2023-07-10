# LINE::Client::MessagingApi::MessagingApiBlobApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_message_content**](MessagingApiBlobApi.md#get_message_content) | **GET** /v2/bot/message/{messageId}/content |  |
| [**get_message_content_preview**](MessagingApiBlobApi.md#get_message_content_preview) | **GET** /v2/bot/message/{messageId}/content/preview |  |
| [**get_message_content_transcoding_by_message_id**](MessagingApiBlobApi.md#get_message_content_transcoding_by_message_id) | **GET** /v2/bot/message/{messageId}/content/transcoding |  |
| [**get_rich_menu_image**](MessagingApiBlobApi.md#get_rich_menu_image) | **GET** /v2/bot/richmenu/{richMenuId}/content |  |
| [**set_rich_menu_image**](MessagingApiBlobApi.md#set_rich_menu_image) | **POST** /v2/bot/richmenu/{richMenuId}/content |  |


## get_message_content

> File get_message_content(message_id)



Download image, video, and audio data sent from users.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiBlobApi.new
message_id = 'message_id_example' # String | Message ID of video or audio

begin
  
  result = api_instance.get_message_content(message_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_message_content: #{e}"
end
```

#### Using the get_message_content_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(File, Integer, Hash)> get_message_content_with_http_info(message_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_message_content_with_http_info(message_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => File
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_message_content_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message_id** | **String** | Message ID of video or audio |  |

### Return type

**File**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: */*


## get_message_content_preview

> File get_message_content_preview(message_id)



Get a preview image of the image or video

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiBlobApi.new
message_id = 'message_id_example' # String | Message ID of image or video

begin
  
  result = api_instance.get_message_content_preview(message_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_message_content_preview: #{e}"
end
```

#### Using the get_message_content_preview_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(File, Integer, Hash)> get_message_content_preview_with_http_info(message_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_message_content_preview_with_http_info(message_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => File
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_message_content_preview_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message_id** | **String** | Message ID of image or video |  |

### Return type

**File**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: */*


## get_message_content_transcoding_by_message_id

> <GetMessageContentTranscodingResponse> get_message_content_transcoding_by_message_id(message_id)



Verify the preparation status of a video or audio for getting

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiBlobApi.new
message_id = 'message_id_example' # String | Message ID of video or audio

begin
  
  result = api_instance.get_message_content_transcoding_by_message_id(message_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_message_content_transcoding_by_message_id: #{e}"
end
```

#### Using the get_message_content_transcoding_by_message_id_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetMessageContentTranscodingResponse>, Integer, Hash)> get_message_content_transcoding_by_message_id_with_http_info(message_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_message_content_transcoding_by_message_id_with_http_info(message_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetMessageContentTranscodingResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_message_content_transcoding_by_message_id_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **message_id** | **String** | Message ID of video or audio |  |

### Return type

[**GetMessageContentTranscodingResponse**](GetMessageContentTranscodingResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu_image

> File get_rich_menu_image(rich_menu_id)



Download rich menu image.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiBlobApi.new
rich_menu_id = 'rich_menu_id_example' # String | ID of the rich menu with the image to be downloaded

begin
  
  result = api_instance.get_rich_menu_image(rich_menu_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_rich_menu_image: #{e}"
end
```

#### Using the get_rich_menu_image_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(File, Integer, Hash)> get_rich_menu_image_with_http_info(rich_menu_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_image_with_http_info(rich_menu_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => File
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->get_rich_menu_image_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | ID of the rich menu with the image to be downloaded |  |

### Return type

**File**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: */*


## set_rich_menu_image

> set_rich_menu_image(rich_menu_id, opts)



Upload rich menu image

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiBlobApi.new
rich_menu_id = 'rich_menu_id_example' # String | The ID of the rich menu to attach the image to
opts = {
  body: File.new('/path/to/some/file') # File | 
}

begin
  
  api_instance.set_rich_menu_image(rich_menu_id, opts)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->set_rich_menu_image: #{e}"
end
```

#### Using the set_rich_menu_image_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> set_rich_menu_image_with_http_info(rich_menu_id, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.set_rich_menu_image_with_http_info(rich_menu_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiBlobApi->set_rich_menu_image_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | The ID of the rich menu to attach the image to |  |
| **body** | **File** |  | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined

