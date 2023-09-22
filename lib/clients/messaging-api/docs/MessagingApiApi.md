# LINE::Client::MessagingApi::MessagingApiApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**audience_match**](MessagingApiApi.md#audience_match) | **POST** /bot/ad/multicast/phone |  |
| [**broadcast**](MessagingApiApi.md#broadcast) | **POST** /v2/bot/message/broadcast |  |
| [**cancel_default_rich_menu**](MessagingApiApi.md#cancel_default_rich_menu) | **DELETE** /v2/bot/user/all/richmenu |  |
| [**create_rich_menu**](MessagingApiApi.md#create_rich_menu) | **POST** /v2/bot/richmenu |  |
| [**create_rich_menu_alias**](MessagingApiApi.md#create_rich_menu_alias) | **POST** /v2/bot/richmenu/alias |  |
| [**delete_rich_menu**](MessagingApiApi.md#delete_rich_menu) | **DELETE** /v2/bot/richmenu/{richMenuId} |  |
| [**delete_rich_menu_alias**](MessagingApiApi.md#delete_rich_menu_alias) | **DELETE** /v2/bot/richmenu/alias/{richMenuAliasId} |  |
| [**get_ad_phone_message_statistics**](MessagingApiApi.md#get_ad_phone_message_statistics) | **GET** /v2/bot/message/delivery/ad_phone |  |
| [**get_aggregation_unit_name_list**](MessagingApiApi.md#get_aggregation_unit_name_list) | **GET** /v2/bot/message/aggregation/list |  |
| [**get_aggregation_unit_usage**](MessagingApiApi.md#get_aggregation_unit_usage) | **GET** /v2/bot/message/aggregation/info |  |
| [**get_bot_info**](MessagingApiApi.md#get_bot_info) | **GET** /v2/bot/info |  |
| [**get_default_rich_menu_id**](MessagingApiApi.md#get_default_rich_menu_id) | **GET** /v2/bot/user/all/richmenu |  |
| [**get_followers**](MessagingApiApi.md#get_followers) | **GET** /v2/bot/followers/ids |  |
| [**get_group_member_count**](MessagingApiApi.md#get_group_member_count) | **GET** /v2/bot/group/{groupId}/members/count |  |
| [**get_group_member_profile**](MessagingApiApi.md#get_group_member_profile) | **GET** /v2/bot/group/{groupId}/member/{userId} |  |
| [**get_group_members_ids**](MessagingApiApi.md#get_group_members_ids) | **GET** /v2/bot/group/{groupId}/members/ids |  |
| [**get_group_summary**](MessagingApiApi.md#get_group_summary) | **GET** /v2/bot/group/{groupId}/summary |  |
| [**get_message_quota**](MessagingApiApi.md#get_message_quota) | **GET** /v2/bot/message/quota |  |
| [**get_message_quota_consumption**](MessagingApiApi.md#get_message_quota_consumption) | **GET** /v2/bot/message/quota/consumption |  |
| [**get_narrowcast_progress**](MessagingApiApi.md#get_narrowcast_progress) | **GET** /v2/bot/message/progress/narrowcast |  |
| [**get_number_of_sent_broadcast_messages**](MessagingApiApi.md#get_number_of_sent_broadcast_messages) | **GET** /v2/bot/message/delivery/broadcast |  |
| [**get_number_of_sent_multicast_messages**](MessagingApiApi.md#get_number_of_sent_multicast_messages) | **GET** /v2/bot/message/delivery/multicast |  |
| [**get_number_of_sent_push_messages**](MessagingApiApi.md#get_number_of_sent_push_messages) | **GET** /v2/bot/message/delivery/push |  |
| [**get_number_of_sent_reply_messages**](MessagingApiApi.md#get_number_of_sent_reply_messages) | **GET** /v2/bot/message/delivery/reply |  |
| [**get_pnp_message_statistics**](MessagingApiApi.md#get_pnp_message_statistics) | **GET** /v2/bot/message/delivery/pnp |  |
| [**get_profile**](MessagingApiApi.md#get_profile) | **GET** /v2/bot/profile/{userId} |  |
| [**get_rich_menu**](MessagingApiApi.md#get_rich_menu) | **GET** /v2/bot/richmenu/{richMenuId} |  |
| [**get_rich_menu_alias**](MessagingApiApi.md#get_rich_menu_alias) | **GET** /v2/bot/richmenu/alias/{richMenuAliasId} |  |
| [**get_rich_menu_alias_list**](MessagingApiApi.md#get_rich_menu_alias_list) | **GET** /v2/bot/richmenu/alias/list |  |
| [**get_rich_menu_batch_progress**](MessagingApiApi.md#get_rich_menu_batch_progress) | **GET** /v2/bot/richmenu/progress/batch |  |
| [**get_rich_menu_id_of_user**](MessagingApiApi.md#get_rich_menu_id_of_user) | **GET** /v2/bot/user/{userId}/richmenu |  |
| [**get_rich_menu_list**](MessagingApiApi.md#get_rich_menu_list) | **GET** /v2/bot/richmenu/list |  |
| [**get_room_member_count**](MessagingApiApi.md#get_room_member_count) | **GET** /v2/bot/room/{roomId}/members/count |  |
| [**get_room_member_profile**](MessagingApiApi.md#get_room_member_profile) | **GET** /v2/bot/room/{roomId}/member/{userId} |  |
| [**get_room_members_ids**](MessagingApiApi.md#get_room_members_ids) | **GET** /v2/bot/room/{roomId}/members/ids |  |
| [**get_webhook_endpoint**](MessagingApiApi.md#get_webhook_endpoint) | **GET** /v2/bot/channel/webhook/endpoint |  |
| [**issue_link_token**](MessagingApiApi.md#issue_link_token) | **POST** /v2/bot/user/{userId}/linkToken |  |
| [**leave_group**](MessagingApiApi.md#leave_group) | **POST** /v2/bot/group/{groupId}/leave |  |
| [**leave_room**](MessagingApiApi.md#leave_room) | **POST** /v2/bot/room/{roomId}/leave |  |
| [**link_rich_menu_id_to_user**](MessagingApiApi.md#link_rich_menu_id_to_user) | **POST** /v2/bot/user/{userId}/richmenu/{richMenuId} |  |
| [**link_rich_menu_id_to_users**](MessagingApiApi.md#link_rich_menu_id_to_users) | **POST** /v2/bot/richmenu/bulk/link |  |
| [**mark_messages_as_read**](MessagingApiApi.md#mark_messages_as_read) | **POST** /v2/bot/message/markAsRead |  |
| [**multicast**](MessagingApiApi.md#multicast) | **POST** /v2/bot/message/multicast |  |
| [**narrowcast**](MessagingApiApi.md#narrowcast) | **POST** /v2/bot/message/narrowcast |  |
| [**push_message**](MessagingApiApi.md#push_message) | **POST** /v2/bot/message/push |  |
| [**push_messages_by_phone**](MessagingApiApi.md#push_messages_by_phone) | **POST** /bot/pnp/push |  |
| [**reply_message**](MessagingApiApi.md#reply_message) | **POST** /v2/bot/message/reply |  |
| [**rich_menu_batch**](MessagingApiApi.md#rich_menu_batch) | **POST** /v2/bot/richmenu/batch |  |
| [**set_default_rich_menu**](MessagingApiApi.md#set_default_rich_menu) | **POST** /v2/bot/user/all/richmenu/{richMenuId} |  |
| [**set_webhook_endpoint**](MessagingApiApi.md#set_webhook_endpoint) | **PUT** /v2/bot/channel/webhook/endpoint |  |
| [**test_webhook_endpoint**](MessagingApiApi.md#test_webhook_endpoint) | **POST** /v2/bot/channel/webhook/test |  |
| [**unlink_rich_menu_id_from_user**](MessagingApiApi.md#unlink_rich_menu_id_from_user) | **DELETE** /v2/bot/user/{userId}/richmenu |  |
| [**unlink_rich_menu_id_from_users**](MessagingApiApi.md#unlink_rich_menu_id_from_users) | **POST** /v2/bot/richmenu/bulk/unlink |  |
| [**update_rich_menu_alias**](MessagingApiApi.md#update_rich_menu_alias) | **POST** /v2/bot/richmenu/alias/{richMenuAliasId} |  |
| [**validate_broadcast**](MessagingApiApi.md#validate_broadcast) | **POST** /v2/bot/message/validate/broadcast |  |
| [**validate_multicast**](MessagingApiApi.md#validate_multicast) | **POST** /v2/bot/message/validate/multicast |  |
| [**validate_narrowcast**](MessagingApiApi.md#validate_narrowcast) | **POST** /v2/bot/message/validate/narrowcast |  |
| [**validate_push**](MessagingApiApi.md#validate_push) | **POST** /v2/bot/message/validate/push |  |
| [**validate_reply**](MessagingApiApi.md#validate_reply) | **POST** /v2/bot/message/validate/reply |  |
| [**validate_rich_menu_batch_request**](MessagingApiApi.md#validate_rich_menu_batch_request) | **POST** /v2/bot/richmenu/validate/batch |  |
| [**validate_rich_menu_object**](MessagingApiApi.md#validate_rich_menu_object) | **POST** /v2/bot/richmenu/validate |  |


## audience_match

> audience_match(audience_match_messages_request)



Send a message using phone number

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
audience_match_messages_request = LINE::Client::MessagingApi::AudienceMatchMessagesRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})], to: ['to_example']}) # AudienceMatchMessagesRequest | 

begin
  
  api_instance.audience_match(audience_match_messages_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->audience_match: #{e}"
end
```

#### Using the audience_match_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> audience_match_with_http_info(audience_match_messages_request)

```ruby
begin
  
  data, status_code, headers = api_instance.audience_match_with_http_info(audience_match_messages_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->audience_match_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_match_messages_request** | [**AudienceMatchMessagesRequest**](AudienceMatchMessagesRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## broadcast

> Object broadcast(broadcast_request, opts)



Sends a message to multiple users at any time.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
broadcast_request = LINE::Client::MessagingApi::BroadcastRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # BroadcastRequest | 
opts = {
  x_line_retry_key: '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | Retry key. Specifies the UUID in hexadecimal format (e.g., `123e4567-e89b-12d3-a456-426614174000`) generated by any method. The retry key isn't generated by LINE. Each developer must generate their own retry key. 
}

begin
  
  result = api_instance.broadcast(broadcast_request, opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->broadcast: #{e}"
end
```

#### Using the broadcast_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> broadcast_with_http_info(broadcast_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.broadcast_with_http_info(broadcast_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->broadcast_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **broadcast_request** | [**BroadcastRequest**](BroadcastRequest.md) |  |  |
| **x_line_retry_key** | **String** | Retry key. Specifies the UUID in hexadecimal format (e.g., &#x60;123e4567-e89b-12d3-a456-426614174000&#x60;) generated by any method. The retry key isn&#39;t generated by LINE. Each developer must generate their own retry key.  | [optional] |

### Return type

**Object**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## cancel_default_rich_menu

> cancel_default_rich_menu



Cancel default rich menu

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  api_instance.cancel_default_rich_menu
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->cancel_default_rich_menu: #{e}"
end
```

#### Using the cancel_default_rich_menu_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> cancel_default_rich_menu_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.cancel_default_rich_menu_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->cancel_default_rich_menu_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## create_rich_menu

> <RichMenuIdResponse> create_rich_menu(rich_menu_request)



Create rich menu

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_request = LINE::Client::MessagingApi::RichMenuRequest.new # RichMenuRequest | 

begin
  
  result = api_instance.create_rich_menu(rich_menu_request)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->create_rich_menu: #{e}"
end
```

#### Using the create_rich_menu_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuIdResponse>, Integer, Hash)> create_rich_menu_with_http_info(rich_menu_request)

```ruby
begin
  
  data, status_code, headers = api_instance.create_rich_menu_with_http_info(rich_menu_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuIdResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->create_rich_menu_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_request** | [**RichMenuRequest**](RichMenuRequest.md) |  |  |

### Return type

[**RichMenuIdResponse**](RichMenuIdResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_rich_menu_alias

> create_rich_menu_alias(create_rich_menu_alias_request)



Create rich menu alias

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
create_rich_menu_alias_request = LINE::Client::MessagingApi::CreateRichMenuAliasRequest.new({rich_menu_alias_id: 'rich_menu_alias_id_example', rich_menu_id: 'rich_menu_id_example'}) # CreateRichMenuAliasRequest | 

begin
  
  api_instance.create_rich_menu_alias(create_rich_menu_alias_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->create_rich_menu_alias: #{e}"
end
```

#### Using the create_rich_menu_alias_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> create_rich_menu_alias_with_http_info(create_rich_menu_alias_request)

```ruby
begin
  
  data, status_code, headers = api_instance.create_rich_menu_alias_with_http_info(create_rich_menu_alias_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->create_rich_menu_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_rich_menu_alias_request** | [**CreateRichMenuAliasRequest**](CreateRichMenuAliasRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_rich_menu

> delete_rich_menu(rich_menu_id)



Deletes a rich menu.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_id = 'rich_menu_id_example' # String | ID of a rich menu

begin
  
  api_instance.delete_rich_menu(rich_menu_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->delete_rich_menu: #{e}"
end
```

#### Using the delete_rich_menu_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_rich_menu_with_http_info(rich_menu_id)

```ruby
begin
  
  data, status_code, headers = api_instance.delete_rich_menu_with_http_info(rich_menu_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->delete_rich_menu_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | ID of a rich menu |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## delete_rich_menu_alias

> delete_rich_menu_alias(rich_menu_alias_id)



Delete rich menu alias

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_alias_id = 'rich_menu_alias_id_example' # String | Rich menu alias ID that you want to delete.

begin
  
  api_instance.delete_rich_menu_alias(rich_menu_alias_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->delete_rich_menu_alias: #{e}"
end
```

#### Using the delete_rich_menu_alias_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_rich_menu_alias_with_http_info(rich_menu_alias_id)

```ruby
begin
  
  data, status_code, headers = api_instance.delete_rich_menu_alias_with_http_info(rich_menu_alias_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->delete_rich_menu_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_alias_id** | **String** | Rich menu alias ID that you want to delete. |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_ad_phone_message_statistics

> <NumberOfMessagesResponse> get_ad_phone_message_statistics(date)



Get result of message delivery using phone number

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
date = 'date_example' # String | Date the message was sent  Format: `yyyyMMdd` (e.g. `20190831`) Time Zone: UTC+9 

begin
  
  result = api_instance.get_ad_phone_message_statistics(date)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_ad_phone_message_statistics: #{e}"
end
```

#### Using the get_ad_phone_message_statistics_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NumberOfMessagesResponse>, Integer, Hash)> get_ad_phone_message_statistics_with_http_info(date)

```ruby
begin
  
  data, status_code, headers = api_instance.get_ad_phone_message_statistics_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NumberOfMessagesResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_ad_phone_message_statistics_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date the message was sent  Format: &#x60;yyyyMMdd&#x60; (e.g. &#x60;20190831&#x60;) Time Zone: UTC+9  |  |

### Return type

[**NumberOfMessagesResponse**](NumberOfMessagesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_aggregation_unit_name_list

> <GetAggregationUnitNameListResponse> get_aggregation_unit_name_list(opts)



Get name list of units used this month

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
opts = {
  limit: 'limit_example', # String | The maximum number of aggregation units you can get per request. 
  start: 'start_example' # String | Value of the continuation token found in the next property of the JSON object returned in the response. If you can't get all the aggregation units in one request, include this parameter to get the remaining array. 
}

begin
  
  result = api_instance.get_aggregation_unit_name_list(opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_aggregation_unit_name_list: #{e}"
end
```

#### Using the get_aggregation_unit_name_list_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAggregationUnitNameListResponse>, Integer, Hash)> get_aggregation_unit_name_list_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_aggregation_unit_name_list_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAggregationUnitNameListResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_aggregation_unit_name_list_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **limit** | **String** | The maximum number of aggregation units you can get per request.  | [optional] |
| **start** | **String** | Value of the continuation token found in the next property of the JSON object returned in the response. If you can&#39;t get all the aggregation units in one request, include this parameter to get the remaining array.  | [optional] |

### Return type

[**GetAggregationUnitNameListResponse**](GetAggregationUnitNameListResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_aggregation_unit_usage

> <GetAggregationUnitUsageResponse> get_aggregation_unit_usage



Get number of units used this month

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_aggregation_unit_usage
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_aggregation_unit_usage: #{e}"
end
```

#### Using the get_aggregation_unit_usage_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAggregationUnitUsageResponse>, Integer, Hash)> get_aggregation_unit_usage_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_aggregation_unit_usage_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAggregationUnitUsageResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_aggregation_unit_usage_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetAggregationUnitUsageResponse**](GetAggregationUnitUsageResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_bot_info

> <BotInfoResponse> get_bot_info



Get bot info

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_bot_info
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_bot_info: #{e}"
end
```

#### Using the get_bot_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<BotInfoResponse>, Integer, Hash)> get_bot_info_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_bot_info_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <BotInfoResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_bot_info_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**BotInfoResponse**](BotInfoResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_default_rich_menu_id

> <RichMenuIdResponse> get_default_rich_menu_id



Gets the ID of the default rich menu set with the Messaging API.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_default_rich_menu_id
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_default_rich_menu_id: #{e}"
end
```

#### Using the get_default_rich_menu_id_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuIdResponse>, Integer, Hash)> get_default_rich_menu_id_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_default_rich_menu_id_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuIdResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_default_rich_menu_id_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**RichMenuIdResponse**](RichMenuIdResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_followers

> <GetFollowersResponse> get_followers(opts)



Get a list of users who added your LINE Official Account as a friend

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
opts = {
  start: 'start_example', # String | Value of the continuation token found in the next property of the JSON object returned in the response. Include this parameter to get the next array of user IDs. 
  limit: 56 # Integer | The maximum number of user IDs to retrieve in a single request.
}

begin
  
  result = api_instance.get_followers(opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_followers: #{e}"
end
```

#### Using the get_followers_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetFollowersResponse>, Integer, Hash)> get_followers_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_followers_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetFollowersResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_followers_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **start** | **String** | Value of the continuation token found in the next property of the JSON object returned in the response. Include this parameter to get the next array of user IDs.  | [optional] |
| **limit** | **Integer** | The maximum number of user IDs to retrieve in a single request. | [optional][default to 300] |

### Return type

[**GetFollowersResponse**](GetFollowersResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_group_member_count

> <GroupMemberCountResponse> get_group_member_count(group_id)



Get number of users in a group chat

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
group_id = 'group_id_example' # String | Group ID

begin
  
  result = api_instance.get_group_member_count(group_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_member_count: #{e}"
end
```

#### Using the get_group_member_count_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GroupMemberCountResponse>, Integer, Hash)> get_group_member_count_with_http_info(group_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_group_member_count_with_http_info(group_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GroupMemberCountResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_member_count_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID |  |

### Return type

[**GroupMemberCountResponse**](GroupMemberCountResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_group_member_profile

> <GroupUserProfileResponse> get_group_member_profile(group_id, user_id)



Get group chat member profile

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
group_id = 'group_id_example' # String | Group ID
user_id = 'user_id_example' # String | User ID

begin
  
  result = api_instance.get_group_member_profile(group_id, user_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_member_profile: #{e}"
end
```

#### Using the get_group_member_profile_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GroupUserProfileResponse>, Integer, Hash)> get_group_member_profile_with_http_info(group_id, user_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_group_member_profile_with_http_info(group_id, user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GroupUserProfileResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_member_profile_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID |  |
| **user_id** | **String** | User ID |  |

### Return type

[**GroupUserProfileResponse**](GroupUserProfileResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_group_members_ids

> <MembersIdsResponse> get_group_members_ids(group_id, opts)



Get group chat member user IDs

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
group_id = 'group_id_example' # String | Group ID
opts = {
  start: 'start_example' # String | Value of the continuation token found in the `next` property of the JSON object returned in the response. Include this parameter to get the next array of user IDs for the members of the group. 
}

begin
  
  result = api_instance.get_group_members_ids(group_id, opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_members_ids: #{e}"
end
```

#### Using the get_group_members_ids_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MembersIdsResponse>, Integer, Hash)> get_group_members_ids_with_http_info(group_id, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_group_members_ids_with_http_info(group_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MembersIdsResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_members_ids_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID |  |
| **start** | **String** | Value of the continuation token found in the &#x60;next&#x60; property of the JSON object returned in the response. Include this parameter to get the next array of user IDs for the members of the group.  | [optional] |

### Return type

[**MembersIdsResponse**](MembersIdsResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_group_summary

> <GroupSummaryResponse> get_group_summary(group_id)



Get group chat summary

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
group_id = 'group_id_example' # String | Group ID

begin
  
  result = api_instance.get_group_summary(group_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_summary: #{e}"
end
```

#### Using the get_group_summary_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GroupSummaryResponse>, Integer, Hash)> get_group_summary_with_http_info(group_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_group_summary_with_http_info(group_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GroupSummaryResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_group_summary_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID |  |

### Return type

[**GroupSummaryResponse**](GroupSummaryResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_message_quota

> <MessageQuotaResponse> get_message_quota



Gets the target limit for sending messages in the current month. The total number of the free messages and the additional messages is returned.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_message_quota
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_message_quota: #{e}"
end
```

#### Using the get_message_quota_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MessageQuotaResponse>, Integer, Hash)> get_message_quota_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_message_quota_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MessageQuotaResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_message_quota_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**MessageQuotaResponse**](MessageQuotaResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_message_quota_consumption

> <QuotaConsumptionResponse> get_message_quota_consumption



Gets the number of messages sent in the current month.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_message_quota_consumption
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_message_quota_consumption: #{e}"
end
```

#### Using the get_message_quota_consumption_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<QuotaConsumptionResponse>, Integer, Hash)> get_message_quota_consumption_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_message_quota_consumption_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <QuotaConsumptionResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_message_quota_consumption_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**QuotaConsumptionResponse**](QuotaConsumptionResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_narrowcast_progress

> <NarrowcastProgressResponse> get_narrowcast_progress(request_id)



Gets the status of a narrowcast message.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
request_id = 'request_id_example' # String | The narrowcast message's request ID. Each Messaging API request has a request ID.

begin
  
  result = api_instance.get_narrowcast_progress(request_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_narrowcast_progress: #{e}"
end
```

#### Using the get_narrowcast_progress_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NarrowcastProgressResponse>, Integer, Hash)> get_narrowcast_progress_with_http_info(request_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_narrowcast_progress_with_http_info(request_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NarrowcastProgressResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_narrowcast_progress_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **request_id** | **String** | The narrowcast message&#39;s request ID. Each Messaging API request has a request ID. |  |

### Return type

[**NarrowcastProgressResponse**](NarrowcastProgressResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_number_of_sent_broadcast_messages

> <NumberOfMessagesResponse> get_number_of_sent_broadcast_messages(date)



Get number of sent broadcast messages

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
date = 'date_example' # String | Date the messages were sent  Format: yyyyMMdd (e.g. 20191231) Timezone: UTC+9 

begin
  
  result = api_instance.get_number_of_sent_broadcast_messages(date)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_broadcast_messages: #{e}"
end
```

#### Using the get_number_of_sent_broadcast_messages_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NumberOfMessagesResponse>, Integer, Hash)> get_number_of_sent_broadcast_messages_with_http_info(date)

```ruby
begin
  
  data, status_code, headers = api_instance.get_number_of_sent_broadcast_messages_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NumberOfMessagesResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_broadcast_messages_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date the messages were sent  Format: yyyyMMdd (e.g. 20191231) Timezone: UTC+9  |  |

### Return type

[**NumberOfMessagesResponse**](NumberOfMessagesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_number_of_sent_multicast_messages

> <NumberOfMessagesResponse> get_number_of_sent_multicast_messages(date)



Get number of sent multicast messages

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
date = 'date_example' # String | Date the messages were sent  Format: `yyyyMMdd` (e.g. `20191231`) Timezone: UTC+9 

begin
  
  result = api_instance.get_number_of_sent_multicast_messages(date)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_multicast_messages: #{e}"
end
```

#### Using the get_number_of_sent_multicast_messages_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NumberOfMessagesResponse>, Integer, Hash)> get_number_of_sent_multicast_messages_with_http_info(date)

```ruby
begin
  
  data, status_code, headers = api_instance.get_number_of_sent_multicast_messages_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NumberOfMessagesResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_multicast_messages_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date the messages were sent  Format: &#x60;yyyyMMdd&#x60; (e.g. &#x60;20191231&#x60;) Timezone: UTC+9  |  |

### Return type

[**NumberOfMessagesResponse**](NumberOfMessagesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_number_of_sent_push_messages

> <NumberOfMessagesResponse> get_number_of_sent_push_messages(date)



Get number of sent push messages

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
date = 'date_example' # String | Date the messages were sent  Format: `yyyyMMdd` (e.g. `20191231`) Timezone: UTC+9 

begin
  
  result = api_instance.get_number_of_sent_push_messages(date)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_push_messages: #{e}"
end
```

#### Using the get_number_of_sent_push_messages_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NumberOfMessagesResponse>, Integer, Hash)> get_number_of_sent_push_messages_with_http_info(date)

```ruby
begin
  
  data, status_code, headers = api_instance.get_number_of_sent_push_messages_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NumberOfMessagesResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_push_messages_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date the messages were sent  Format: &#x60;yyyyMMdd&#x60; (e.g. &#x60;20191231&#x60;) Timezone: UTC+9  |  |

### Return type

[**NumberOfMessagesResponse**](NumberOfMessagesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_number_of_sent_reply_messages

> <NumberOfMessagesResponse> get_number_of_sent_reply_messages(date)



Get number of sent reply messages

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
date = 'date_example' # String | Date the messages were sent  Format: `yyyyMMdd` (e.g. `20191231`) Timezone: UTC+9 

begin
  
  result = api_instance.get_number_of_sent_reply_messages(date)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_reply_messages: #{e}"
end
```

#### Using the get_number_of_sent_reply_messages_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NumberOfMessagesResponse>, Integer, Hash)> get_number_of_sent_reply_messages_with_http_info(date)

```ruby
begin
  
  data, status_code, headers = api_instance.get_number_of_sent_reply_messages_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NumberOfMessagesResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_number_of_sent_reply_messages_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date the messages were sent  Format: &#x60;yyyyMMdd&#x60; (e.g. &#x60;20191231&#x60;) Timezone: UTC+9  |  |

### Return type

[**NumberOfMessagesResponse**](NumberOfMessagesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_pnp_message_statistics

> <NumberOfMessagesResponse> get_pnp_message_statistics(date)



Get number of sent LINE notification messages　

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
date = 'date_example' # String | Date the message was sent  Format: `yyyyMMdd` (Example:`20211231`) Time zone: UTC+9 

begin
  
  result = api_instance.get_pnp_message_statistics(date)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_pnp_message_statistics: #{e}"
end
```

#### Using the get_pnp_message_statistics_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NumberOfMessagesResponse>, Integer, Hash)> get_pnp_message_statistics_with_http_info(date)

```ruby
begin
  
  data, status_code, headers = api_instance.get_pnp_message_statistics_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NumberOfMessagesResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_pnp_message_statistics_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date the message was sent  Format: &#x60;yyyyMMdd&#x60; (Example:&#x60;20211231&#x60;) Time zone: UTC+9  |  |

### Return type

[**NumberOfMessagesResponse**](NumberOfMessagesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_profile

> <UserProfileResponse> get_profile(user_id)



Get profile

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
user_id = 'user_id_example' # String | User ID

begin
  
  result = api_instance.get_profile(user_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_profile: #{e}"
end
```

#### Using the get_profile_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<UserProfileResponse>, Integer, Hash)> get_profile_with_http_info(user_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_profile_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <UserProfileResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_profile_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | User ID |  |

### Return type

[**UserProfileResponse**](UserProfileResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu

> <RichMenuResponse> get_rich_menu(rich_menu_id)



Gets a rich menu via a rich menu ID.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_id = 'rich_menu_id_example' # String | ID of a rich menu

begin
  
  result = api_instance.get_rich_menu(rich_menu_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu: #{e}"
end
```

#### Using the get_rich_menu_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuResponse>, Integer, Hash)> get_rich_menu_with_http_info(rich_menu_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_with_http_info(rich_menu_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | ID of a rich menu |  |

### Return type

[**RichMenuResponse**](RichMenuResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu_alias

> <RichMenuAliasResponse> get_rich_menu_alias(rich_menu_alias_id)



Get rich menu alias information

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_alias_id = 'rich_menu_alias_id_example' # String | The rich menu alias ID whose information you want to obtain.

begin
  
  result = api_instance.get_rich_menu_alias(rich_menu_alias_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_alias: #{e}"
end
```

#### Using the get_rich_menu_alias_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuAliasResponse>, Integer, Hash)> get_rich_menu_alias_with_http_info(rich_menu_alias_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_alias_with_http_info(rich_menu_alias_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuAliasResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_alias_id** | **String** | The rich menu alias ID whose information you want to obtain. |  |

### Return type

[**RichMenuAliasResponse**](RichMenuAliasResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu_alias_list

> <RichMenuAliasListResponse> get_rich_menu_alias_list



Get list of rich menu alias

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_rich_menu_alias_list
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_alias_list: #{e}"
end
```

#### Using the get_rich_menu_alias_list_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuAliasListResponse>, Integer, Hash)> get_rich_menu_alias_list_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_alias_list_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuAliasListResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_alias_list_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**RichMenuAliasListResponse**](RichMenuAliasListResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu_batch_progress

> <RichMenuBatchProgressResponse> get_rich_menu_batch_progress(request_id)



Get the status of Replace or unlink a linked rich menus in batches.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
request_id = 'request_id_example' # String | A request ID used to batch control the rich menu linked to the user. Each Messaging API request has a request ID.

begin
  
  result = api_instance.get_rich_menu_batch_progress(request_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_batch_progress: #{e}"
end
```

#### Using the get_rich_menu_batch_progress_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuBatchProgressResponse>, Integer, Hash)> get_rich_menu_batch_progress_with_http_info(request_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_batch_progress_with_http_info(request_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuBatchProgressResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_batch_progress_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **request_id** | **String** | A request ID used to batch control the rich menu linked to the user. Each Messaging API request has a request ID. |  |

### Return type

[**RichMenuBatchProgressResponse**](RichMenuBatchProgressResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu_id_of_user

> <RichMenuIdResponse> get_rich_menu_id_of_user(user_id)



Get rich menu ID of user

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
user_id = 'user_id_example' # String | User ID. Found in the `source` object of webhook event objects. Do not use the LINE ID used in LINE.

begin
  
  result = api_instance.get_rich_menu_id_of_user(user_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_id_of_user: #{e}"
end
```

#### Using the get_rich_menu_id_of_user_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuIdResponse>, Integer, Hash)> get_rich_menu_id_of_user_with_http_info(user_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_id_of_user_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuIdResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_id_of_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | User ID. Found in the &#x60;source&#x60; object of webhook event objects. Do not use the LINE ID used in LINE. |  |

### Return type

[**RichMenuIdResponse**](RichMenuIdResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_rich_menu_list

> <RichMenuListResponse> get_rich_menu_list



Get rich menu list

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_rich_menu_list
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_list: #{e}"
end
```

#### Using the get_rich_menu_list_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RichMenuListResponse>, Integer, Hash)> get_rich_menu_list_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_rich_menu_list_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RichMenuListResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_rich_menu_list_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**RichMenuListResponse**](RichMenuListResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_room_member_count

> <RoomMemberCountResponse> get_room_member_count(room_id)



Get number of users in a multi-person chat

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
room_id = 'room_id_example' # String | Room ID

begin
  
  result = api_instance.get_room_member_count(room_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_room_member_count: #{e}"
end
```

#### Using the get_room_member_count_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RoomMemberCountResponse>, Integer, Hash)> get_room_member_count_with_http_info(room_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_room_member_count_with_http_info(room_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RoomMemberCountResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_room_member_count_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **room_id** | **String** | Room ID |  |

### Return type

[**RoomMemberCountResponse**](RoomMemberCountResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_room_member_profile

> <RoomUserProfileResponse> get_room_member_profile(room_id, user_id)



Get multi-person chat member profile

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
room_id = 'room_id_example' # String | Room ID
user_id = 'user_id_example' # String | User ID

begin
  
  result = api_instance.get_room_member_profile(room_id, user_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_room_member_profile: #{e}"
end
```

#### Using the get_room_member_profile_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<RoomUserProfileResponse>, Integer, Hash)> get_room_member_profile_with_http_info(room_id, user_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_room_member_profile_with_http_info(room_id, user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <RoomUserProfileResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_room_member_profile_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **room_id** | **String** | Room ID |  |
| **user_id** | **String** | User ID |  |

### Return type

[**RoomUserProfileResponse**](RoomUserProfileResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_room_members_ids

> <MembersIdsResponse> get_room_members_ids(room_id, opts)



Get multi-person chat member user IDs

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
room_id = 'room_id_example' # String | Room ID
opts = {
  start: 'start_example' # String | Value of the continuation token found in the `next` property of the JSON object returned in the response. Include this parameter to get the next array of user IDs for the members of the group. 
}

begin
  
  result = api_instance.get_room_members_ids(room_id, opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_room_members_ids: #{e}"
end
```

#### Using the get_room_members_ids_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<MembersIdsResponse>, Integer, Hash)> get_room_members_ids_with_http_info(room_id, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.get_room_members_ids_with_http_info(room_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <MembersIdsResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_room_members_ids_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **room_id** | **String** | Room ID |  |
| **start** | **String** | Value of the continuation token found in the &#x60;next&#x60; property of the JSON object returned in the response. Include this parameter to get the next array of user IDs for the members of the group.  | [optional] |

### Return type

[**MembersIdsResponse**](MembersIdsResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_webhook_endpoint

> <GetWebhookEndpointResponse> get_webhook_endpoint



Get webhook endpoint information

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new

begin
  
  result = api_instance.get_webhook_endpoint
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_webhook_endpoint: #{e}"
end
```

#### Using the get_webhook_endpoint_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetWebhookEndpointResponse>, Integer, Hash)> get_webhook_endpoint_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_webhook_endpoint_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetWebhookEndpointResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->get_webhook_endpoint_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetWebhookEndpointResponse**](GetWebhookEndpointResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## issue_link_token

> <IssueLinkTokenResponse> issue_link_token(user_id)



Issue link token

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
user_id = 'user_id_example' # String | User ID for the LINE account to be linked. Found in the `source` object of account link event objects. Do not use the LINE ID used in LINE. 

begin
  
  result = api_instance.issue_link_token(user_id)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->issue_link_token: #{e}"
end
```

#### Using the issue_link_token_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<IssueLinkTokenResponse>, Integer, Hash)> issue_link_token_with_http_info(user_id)

```ruby
begin
  
  data, status_code, headers = api_instance.issue_link_token_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <IssueLinkTokenResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->issue_link_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | User ID for the LINE account to be linked. Found in the &#x60;source&#x60; object of account link event objects. Do not use the LINE ID used in LINE.  |  |

### Return type

[**IssueLinkTokenResponse**](IssueLinkTokenResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## leave_group

> leave_group(group_id)



Leave group chat

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
group_id = 'group_id_example' # String | Group ID

begin
  
  api_instance.leave_group(group_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->leave_group: #{e}"
end
```

#### Using the leave_group_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> leave_group_with_http_info(group_id)

```ruby
begin
  
  data, status_code, headers = api_instance.leave_group_with_http_info(group_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->leave_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_id** | **String** | Group ID |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## leave_room

> leave_room(room_id)



Leave multi-person chat

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
room_id = 'room_id_example' # String | Room ID

begin
  
  api_instance.leave_room(room_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->leave_room: #{e}"
end
```

#### Using the leave_room_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> leave_room_with_http_info(room_id)

```ruby
begin
  
  data, status_code, headers = api_instance.leave_room_with_http_info(room_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->leave_room_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **room_id** | **String** | Room ID |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## link_rich_menu_id_to_user

> link_rich_menu_id_to_user(user_id, rich_menu_id)



Link rich menu to user.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
user_id = 'user_id_example' # String | User ID. Found in the `source` object of webhook event objects. Do not use the LINE ID used in LINE.
rich_menu_id = 'rich_menu_id_example' # String | ID of a rich menu

begin
  
  api_instance.link_rich_menu_id_to_user(user_id, rich_menu_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->link_rich_menu_id_to_user: #{e}"
end
```

#### Using the link_rich_menu_id_to_user_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> link_rich_menu_id_to_user_with_http_info(user_id, rich_menu_id)

```ruby
begin
  
  data, status_code, headers = api_instance.link_rich_menu_id_to_user_with_http_info(user_id, rich_menu_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->link_rich_menu_id_to_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | User ID. Found in the &#x60;source&#x60; object of webhook event objects. Do not use the LINE ID used in LINE. |  |
| **rich_menu_id** | **String** | ID of a rich menu |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## link_rich_menu_id_to_users

> link_rich_menu_id_to_users(rich_menu_bulk_link_request)



Link rich menu to multiple users

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_bulk_link_request = LINE::Client::MessagingApi::RichMenuBulkLinkRequest.new({rich_menu_id: 'rich_menu_id_example', user_ids: ['user_ids_example']}) # RichMenuBulkLinkRequest | 

begin
  
  api_instance.link_rich_menu_id_to_users(rich_menu_bulk_link_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->link_rich_menu_id_to_users: #{e}"
end
```

#### Using the link_rich_menu_id_to_users_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> link_rich_menu_id_to_users_with_http_info(rich_menu_bulk_link_request)

```ruby
begin
  
  data, status_code, headers = api_instance.link_rich_menu_id_to_users_with_http_info(rich_menu_bulk_link_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->link_rich_menu_id_to_users_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_bulk_link_request** | [**RichMenuBulkLinkRequest**](RichMenuBulkLinkRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## mark_messages_as_read

> mark_messages_as_read(mark_messages_as_read_request)



Mark messages from users as read

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
mark_messages_as_read_request = LINE::Client::MessagingApi::MarkMessagesAsReadRequest.new({chat: LINE::Client::MessagingApi::ChatReference.new({user_id: 'user_id_example'})}) # MarkMessagesAsReadRequest | 

begin
  
  api_instance.mark_messages_as_read(mark_messages_as_read_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->mark_messages_as_read: #{e}"
end
```

#### Using the mark_messages_as_read_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> mark_messages_as_read_with_http_info(mark_messages_as_read_request)

```ruby
begin
  
  data, status_code, headers = api_instance.mark_messages_as_read_with_http_info(mark_messages_as_read_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->mark_messages_as_read_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **mark_messages_as_read_request** | [**MarkMessagesAsReadRequest**](MarkMessagesAsReadRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## multicast

> Object multicast(multicast_request, opts)



An API that efficiently sends the same message to multiple user IDs. You can't send messages to group chats or multi-person chats.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
multicast_request = LINE::Client::MessagingApi::MulticastRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})], to: ['to_example']}) # MulticastRequest | 
opts = {
  x_line_retry_key: '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | Retry key. Specifies the UUID in hexadecimal format (e.g., `123e4567-e89b-12d3-a456-426614174000`) generated by any method. The retry key isn't generated by LINE. Each developer must generate their own retry key. 
}

begin
  
  result = api_instance.multicast(multicast_request, opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->multicast: #{e}"
end
```

#### Using the multicast_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> multicast_with_http_info(multicast_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.multicast_with_http_info(multicast_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->multicast_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **multicast_request** | [**MulticastRequest**](MulticastRequest.md) |  |  |
| **x_line_retry_key** | **String** | Retry key. Specifies the UUID in hexadecimal format (e.g., &#x60;123e4567-e89b-12d3-a456-426614174000&#x60;) generated by any method. The retry key isn&#39;t generated by LINE. Each developer must generate their own retry key.  | [optional] |

### Return type

**Object**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## narrowcast

> Object narrowcast(narrowcast_request, opts)



Send narrowcast message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
narrowcast_request = LINE::Client::MessagingApi::NarrowcastRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # NarrowcastRequest | 
opts = {
  x_line_retry_key: '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | Retry key. Specifies the UUID in hexadecimal format (e.g., `123e4567-e89b-12d3-a456-426614174000`) generated by any method. The retry key isn't generated by LINE. Each developer must generate their own retry key. 
}

begin
  
  result = api_instance.narrowcast(narrowcast_request, opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->narrowcast: #{e}"
end
```

#### Using the narrowcast_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> narrowcast_with_http_info(narrowcast_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.narrowcast_with_http_info(narrowcast_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->narrowcast_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **narrowcast_request** | [**NarrowcastRequest**](NarrowcastRequest.md) |  |  |
| **x_line_retry_key** | **String** | Retry key. Specifies the UUID in hexadecimal format (e.g., &#x60;123e4567-e89b-12d3-a456-426614174000&#x60;) generated by any method. The retry key isn&#39;t generated by LINE. Each developer must generate their own retry key.  | [optional] |

### Return type

**Object**

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## push_message

> <PushMessageResponse> push_message(push_message_request, opts)



Sends a message to a user, group chat, or multi-person chat at any time.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
push_message_request = LINE::Client::MessagingApi::PushMessageRequest.new({to: 'to_example', messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # PushMessageRequest | 
opts = {
  x_line_retry_key: '38400000-8cf0-11bd-b23e-10b96e4ef00d' # String | Retry key. Specifies the UUID in hexadecimal format (e.g., `123e4567-e89b-12d3-a456-426614174000`) generated by any method. The retry key isn't generated by LINE. Each developer must generate their own retry key. 
}

begin
  
  result = api_instance.push_message(push_message_request, opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->push_message: #{e}"
end
```

#### Using the push_message_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<PushMessageResponse>, Integer, Hash)> push_message_with_http_info(push_message_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.push_message_with_http_info(push_message_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <PushMessageResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->push_message_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **push_message_request** | [**PushMessageRequest**](PushMessageRequest.md) |  |  |
| **x_line_retry_key** | **String** | Retry key. Specifies the UUID in hexadecimal format (e.g., &#x60;123e4567-e89b-12d3-a456-426614174000&#x60;) generated by any method. The retry key isn&#39;t generated by LINE. Each developer must generate their own retry key.  | [optional] |

### Return type

[**PushMessageResponse**](PushMessageResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## push_messages_by_phone

> push_messages_by_phone(pnp_messages_request, opts)



Send LINE notification message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
pnp_messages_request = LINE::Client::MessagingApi::PnpMessagesRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})], to: 'to_example'}) # PnpMessagesRequest | 
opts = {
  x_line_delivery_tag: 'x_line_delivery_tag_example' # String | String returned in the delivery.data property of the delivery completion event via Webhook.
}

begin
  
  api_instance.push_messages_by_phone(pnp_messages_request, opts)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->push_messages_by_phone: #{e}"
end
```

#### Using the push_messages_by_phone_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> push_messages_by_phone_with_http_info(pnp_messages_request, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.push_messages_by_phone_with_http_info(pnp_messages_request, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->push_messages_by_phone_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **pnp_messages_request** | [**PnpMessagesRequest**](PnpMessagesRequest.md) |  |  |
| **x_line_delivery_tag** | **String** | String returned in the delivery.data property of the delivery completion event via Webhook. | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## reply_message

> <ReplyMessageResponse> reply_message(reply_message_request)



Send reply message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
reply_message_request = LINE::Client::MessagingApi::ReplyMessageRequest.new({reply_token: 'reply_token_example', messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # ReplyMessageRequest | 

begin
  
  result = api_instance.reply_message(reply_message_request)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->reply_message: #{e}"
end
```

#### Using the reply_message_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ReplyMessageResponse>, Integer, Hash)> reply_message_with_http_info(reply_message_request)

```ruby
begin
  
  data, status_code, headers = api_instance.reply_message_with_http_info(reply_message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ReplyMessageResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->reply_message_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reply_message_request** | [**ReplyMessageRequest**](ReplyMessageRequest.md) |  |  |

### Return type

[**ReplyMessageResponse**](ReplyMessageResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## rich_menu_batch

> rich_menu_batch(rich_menu_batch_request)



You can use this endpoint to batch control the rich menu linked to the users using the endpoint such as Link rich menu to user.  The following operations are available:  1. Replace a rich menu with another rich menu for all users linked to a specific rich menu 2. Unlink a rich menu for all users linked to a specific rich menu 3. Unlink a rich menu for all users linked the rich menu 

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_batch_request = LINE::Client::MessagingApi::RichMenuBatchRequest.new({operations: [LINE::Client::MessagingApi::RichMenuBatchOperation.new({type: 'type_example'})]}) # RichMenuBatchRequest | 

begin
  
  api_instance.rich_menu_batch(rich_menu_batch_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->rich_menu_batch: #{e}"
end
```

#### Using the rich_menu_batch_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> rich_menu_batch_with_http_info(rich_menu_batch_request)

```ruby
begin
  
  data, status_code, headers = api_instance.rich_menu_batch_with_http_info(rich_menu_batch_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->rich_menu_batch_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_batch_request** | [**RichMenuBatchRequest**](RichMenuBatchRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## set_default_rich_menu

> set_default_rich_menu(rich_menu_id)



Set default rich menu

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_id = 'rich_menu_id_example' # String | ID of a rich menu

begin
  
  api_instance.set_default_rich_menu(rich_menu_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->set_default_rich_menu: #{e}"
end
```

#### Using the set_default_rich_menu_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> set_default_rich_menu_with_http_info(rich_menu_id)

```ruby
begin
  
  data, status_code, headers = api_instance.set_default_rich_menu_with_http_info(rich_menu_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->set_default_rich_menu_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_id** | **String** | ID of a rich menu |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## set_webhook_endpoint

> set_webhook_endpoint(set_webhook_endpoint_request)



Set webhook endpoint URL

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
set_webhook_endpoint_request = LINE::Client::MessagingApi::SetWebhookEndpointRequest.new({endpoint: 'endpoint_example'}) # SetWebhookEndpointRequest | 

begin
  
  api_instance.set_webhook_endpoint(set_webhook_endpoint_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->set_webhook_endpoint: #{e}"
end
```

#### Using the set_webhook_endpoint_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> set_webhook_endpoint_with_http_info(set_webhook_endpoint_request)

```ruby
begin
  
  data, status_code, headers = api_instance.set_webhook_endpoint_with_http_info(set_webhook_endpoint_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->set_webhook_endpoint_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **set_webhook_endpoint_request** | [**SetWebhookEndpointRequest**](SetWebhookEndpointRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## test_webhook_endpoint

> <TestWebhookEndpointResponse> test_webhook_endpoint(opts)



Test webhook endpoint

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
opts = {
  test_webhook_endpoint_request: LINE::Client::MessagingApi::TestWebhookEndpointRequest.new # TestWebhookEndpointRequest | 
}

begin
  
  result = api_instance.test_webhook_endpoint(opts)
  p result
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->test_webhook_endpoint: #{e}"
end
```

#### Using the test_webhook_endpoint_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<TestWebhookEndpointResponse>, Integer, Hash)> test_webhook_endpoint_with_http_info(opts)

```ruby
begin
  
  data, status_code, headers = api_instance.test_webhook_endpoint_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <TestWebhookEndpointResponse>
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->test_webhook_endpoint_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **test_webhook_endpoint_request** | [**TestWebhookEndpointRequest**](TestWebhookEndpointRequest.md) |  | [optional] |

### Return type

[**TestWebhookEndpointResponse**](TestWebhookEndpointResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## unlink_rich_menu_id_from_user

> unlink_rich_menu_id_from_user(user_id)



Unlink rich menu from user

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
user_id = 'user_id_example' # String | User ID. Found in the `source` object of webhook event objects. Do not use the LINE ID used in LINE.

begin
  
  api_instance.unlink_rich_menu_id_from_user(user_id)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->unlink_rich_menu_id_from_user: #{e}"
end
```

#### Using the unlink_rich_menu_id_from_user_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> unlink_rich_menu_id_from_user_with_http_info(user_id)

```ruby
begin
  
  data, status_code, headers = api_instance.unlink_rich_menu_id_from_user_with_http_info(user_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->unlink_rich_menu_id_from_user_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **user_id** | **String** | User ID. Found in the &#x60;source&#x60; object of webhook event objects. Do not use the LINE ID used in LINE. |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## unlink_rich_menu_id_from_users

> unlink_rich_menu_id_from_users(rich_menu_bulk_unlink_request)



Unlink rich menus from multiple users

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_bulk_unlink_request = LINE::Client::MessagingApi::RichMenuBulkUnlinkRequest.new({user_ids: ['user_ids_example']}) # RichMenuBulkUnlinkRequest | 

begin
  
  api_instance.unlink_rich_menu_id_from_users(rich_menu_bulk_unlink_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->unlink_rich_menu_id_from_users: #{e}"
end
```

#### Using the unlink_rich_menu_id_from_users_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> unlink_rich_menu_id_from_users_with_http_info(rich_menu_bulk_unlink_request)

```ruby
begin
  
  data, status_code, headers = api_instance.unlink_rich_menu_id_from_users_with_http_info(rich_menu_bulk_unlink_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->unlink_rich_menu_id_from_users_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_bulk_unlink_request** | [**RichMenuBulkUnlinkRequest**](RichMenuBulkUnlinkRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## update_rich_menu_alias

> update_rich_menu_alias(rich_menu_alias_id, update_rich_menu_alias_request)



Update rich menu alias

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_alias_id = 'rich_menu_alias_id_example' # String | The rich menu alias ID you want to update.
update_rich_menu_alias_request = LINE::Client::MessagingApi::UpdateRichMenuAliasRequest.new({rich_menu_id: 'rich_menu_id_example'}) # UpdateRichMenuAliasRequest | 

begin
  
  api_instance.update_rich_menu_alias(rich_menu_alias_id, update_rich_menu_alias_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->update_rich_menu_alias: #{e}"
end
```

#### Using the update_rich_menu_alias_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> update_rich_menu_alias_with_http_info(rich_menu_alias_id, update_rich_menu_alias_request)

```ruby
begin
  
  data, status_code, headers = api_instance.update_rich_menu_alias_with_http_info(rich_menu_alias_id, update_rich_menu_alias_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->update_rich_menu_alias_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_alias_id** | **String** | The rich menu alias ID you want to update. |  |
| **update_rich_menu_alias_request** | [**UpdateRichMenuAliasRequest**](UpdateRichMenuAliasRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## validate_broadcast

> validate_broadcast(validate_message_request)



Validate message objects of a broadcast message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
validate_message_request = LINE::Client::MessagingApi::ValidateMessageRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # ValidateMessageRequest | 

begin
  
  api_instance.validate_broadcast(validate_message_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_broadcast: #{e}"
end
```

#### Using the validate_broadcast_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_broadcast_with_http_info(validate_message_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_broadcast_with_http_info(validate_message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_broadcast_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **validate_message_request** | [**ValidateMessageRequest**](ValidateMessageRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## validate_multicast

> validate_multicast(validate_message_request)



Validate message objects of a multicast message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
validate_message_request = LINE::Client::MessagingApi::ValidateMessageRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # ValidateMessageRequest | 

begin
  
  api_instance.validate_multicast(validate_message_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_multicast: #{e}"
end
```

#### Using the validate_multicast_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_multicast_with_http_info(validate_message_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_multicast_with_http_info(validate_message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_multicast_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **validate_message_request** | [**ValidateMessageRequest**](ValidateMessageRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## validate_narrowcast

> validate_narrowcast(validate_message_request)



Validate message objects of a narrowcast message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
validate_message_request = LINE::Client::MessagingApi::ValidateMessageRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # ValidateMessageRequest | 

begin
  
  api_instance.validate_narrowcast(validate_message_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_narrowcast: #{e}"
end
```

#### Using the validate_narrowcast_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_narrowcast_with_http_info(validate_message_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_narrowcast_with_http_info(validate_message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_narrowcast_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **validate_message_request** | [**ValidateMessageRequest**](ValidateMessageRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## validate_push

> validate_push(validate_message_request)



Validate message objects of a push message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
validate_message_request = LINE::Client::MessagingApi::ValidateMessageRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # ValidateMessageRequest | 

begin
  
  api_instance.validate_push(validate_message_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_push: #{e}"
end
```

#### Using the validate_push_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_push_with_http_info(validate_message_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_push_with_http_info(validate_message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_push_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **validate_message_request** | [**ValidateMessageRequest**](ValidateMessageRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## validate_reply

> validate_reply(validate_message_request)



Validate message objects of a reply message

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
validate_message_request = LINE::Client::MessagingApi::ValidateMessageRequest.new({messages: [LINE::Client::MessagingApi::Message.new({type: 'type_example'})]}) # ValidateMessageRequest | 

begin
  
  api_instance.validate_reply(validate_message_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_reply: #{e}"
end
```

#### Using the validate_reply_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_reply_with_http_info(validate_message_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_reply_with_http_info(validate_message_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_reply_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **validate_message_request** | [**ValidateMessageRequest**](ValidateMessageRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## validate_rich_menu_batch_request

> validate_rich_menu_batch_request(rich_menu_batch_request)



Validate a request body of the Replace or unlink the linked rich menus in batches endpoint.

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_batch_request = LINE::Client::MessagingApi::RichMenuBatchRequest.new({operations: [LINE::Client::MessagingApi::RichMenuBatchOperation.new({type: 'type_example'})]}) # RichMenuBatchRequest | 

begin
  
  api_instance.validate_rich_menu_batch_request(rich_menu_batch_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_rich_menu_batch_request: #{e}"
end
```

#### Using the validate_rich_menu_batch_request_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_rich_menu_batch_request_with_http_info(rich_menu_batch_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_rich_menu_batch_request_with_http_info(rich_menu_batch_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_rich_menu_batch_request_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_batch_request** | [**RichMenuBatchRequest**](RichMenuBatchRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## validate_rich_menu_object

> validate_rich_menu_object(rich_menu_request)



Validate rich menu object

### Examples

```ruby
require 'time'
require 'line_client_messaging_api'
# setup authorization
LINE::Client::MessagingApi.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::MessagingApi::MessagingApiApi.new
rich_menu_request = LINE::Client::MessagingApi::RichMenuRequest.new # RichMenuRequest | 

begin
  
  api_instance.validate_rich_menu_object(rich_menu_request)
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_rich_menu_object: #{e}"
end
```

#### Using the validate_rich_menu_object_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> validate_rich_menu_object_with_http_info(rich_menu_request)

```ruby
begin
  
  data, status_code, headers = api_instance.validate_rich_menu_object_with_http_info(rich_menu_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::MessagingApi::ApiError => e
  puts "Error when calling MessagingApiApi->validate_rich_menu_object_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **rich_menu_request** | [**RichMenuRequest**](RichMenuRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

