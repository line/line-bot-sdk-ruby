# LINE::Client::Insight::InsightApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_friends_demographics**](InsightApi.md#get_friends_demographics) | **GET** /v2/bot/insight/demographic |  |
| [**get_message_event**](InsightApi.md#get_message_event) | **GET** /v2/bot/insight/message/event | Get user interaction statistics |
| [**get_number_of_followers**](InsightApi.md#get_number_of_followers) | **GET** /v2/bot/insight/followers | Get number of followers |
| [**get_number_of_message_deliveries**](InsightApi.md#get_number_of_message_deliveries) | **GET** /v2/bot/insight/message/delivery | Get number of message deliveries |
| [**get_statistics_per_unit**](InsightApi.md#get_statistics_per_unit) | **GET** /v2/bot/insight/message/event/aggregation |  |


## get_friends_demographics

> <GetFriendsDemographicsResponse> get_friends_demographics



Retrieves the demographic attributes for a LINE Official Account's friends.You can only retrieve information about friends for LINE Official Accounts created by users in Japan (JP), Thailand (TH), Taiwan (TW) and Indonesia (ID). 

### Examples

```ruby
require 'time'
require 'line_client_insight'
# setup authorization
LINE::Client::Insight.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Insight::InsightApi.new

begin
  
  result = api_instance.get_friends_demographics
  p result
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_friends_demographics: #{e}"
end
```

#### Using the get_friends_demographics_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetFriendsDemographicsResponse>, Integer, Hash)> get_friends_demographics_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_friends_demographics_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetFriendsDemographicsResponse>
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_friends_demographics_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetFriendsDemographicsResponse**](GetFriendsDemographicsResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_message_event

> <GetMessageEventResponse> get_message_event(request_id)

Get user interaction statistics

Returns statistics about how users interact with narrowcast messages or broadcast messages sent from your LINE Official Account. 

### Examples

```ruby
require 'time'
require 'line_client_insight'
# setup authorization
LINE::Client::Insight.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Insight::InsightApi.new
request_id = 'request_id_example' # String | Request ID of a narrowcast message or broadcast message. Each Messaging API request has a request ID. 

begin
  # Get user interaction statistics
  result = api_instance.get_message_event(request_id)
  p result
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_message_event: #{e}"
end
```

#### Using the get_message_event_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetMessageEventResponse>, Integer, Hash)> get_message_event_with_http_info(request_id)

```ruby
begin
  # Get user interaction statistics
  data, status_code, headers = api_instance.get_message_event_with_http_info(request_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetMessageEventResponse>
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_message_event_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **request_id** | **String** | Request ID of a narrowcast message or broadcast message. Each Messaging API request has a request ID.  |  |

### Return type

[**GetMessageEventResponse**](GetMessageEventResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_number_of_followers

> <GetNumberOfFollowersResponse> get_number_of_followers(opts)

Get number of followers

Returns the number of users who have added the LINE Official Account on or before a specified date. 

### Examples

```ruby
require 'time'
require 'line_client_insight'
# setup authorization
LINE::Client::Insight.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Insight::InsightApi.new
opts = {
  date: 'date_example' # String | Date for which to retrieve the number of followers.  Format: yyyyMMdd (e.g. 20191231) Timezone: UTC+9 
}

begin
  # Get number of followers
  result = api_instance.get_number_of_followers(opts)
  p result
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_number_of_followers: #{e}"
end
```

#### Using the get_number_of_followers_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetNumberOfFollowersResponse>, Integer, Hash)> get_number_of_followers_with_http_info(opts)

```ruby
begin
  # Get number of followers
  data, status_code, headers = api_instance.get_number_of_followers_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetNumberOfFollowersResponse>
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_number_of_followers_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date for which to retrieve the number of followers.  Format: yyyyMMdd (e.g. 20191231) Timezone: UTC+9  | [optional] |

### Return type

[**GetNumberOfFollowersResponse**](GetNumberOfFollowersResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_number_of_message_deliveries

> <GetNumberOfMessageDeliveriesResponse> get_number_of_message_deliveries(date)

Get number of message deliveries

Returns the number of messages sent from LINE Official Account on a specified day. 

### Examples

```ruby
require 'time'
require 'line_client_insight'
# setup authorization
LINE::Client::Insight.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Insight::InsightApi.new
date = 'date_example' # String | Date for which to retrieve number of sent messages. - Format: yyyyMMdd (e.g. 20191231) - Timezone: UTC+9 

begin
  # Get number of message deliveries
  result = api_instance.get_number_of_message_deliveries(date)
  p result
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_number_of_message_deliveries: #{e}"
end
```

#### Using the get_number_of_message_deliveries_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetNumberOfMessageDeliveriesResponse>, Integer, Hash)> get_number_of_message_deliveries_with_http_info(date)

```ruby
begin
  # Get number of message deliveries
  data, status_code, headers = api_instance.get_number_of_message_deliveries_with_http_info(date)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetNumberOfMessageDeliveriesResponse>
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_number_of_message_deliveries_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **date** | **String** | Date for which to retrieve number of sent messages. - Format: yyyyMMdd (e.g. 20191231) - Timezone: UTC+9  |  |

### Return type

[**GetNumberOfMessageDeliveriesResponse**](GetNumberOfMessageDeliveriesResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_statistics_per_unit

> <GetStatisticsPerUnitResponse> get_statistics_per_unit(custom_aggregation_unit, from, to)



You can check the per-unit statistics of how users interact with push messages and multicast messages sent from your LINE Official Account. 

### Examples

```ruby
require 'time'
require 'line_client_insight'
# setup authorization
LINE::Client::Insight.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::Insight::InsightApi.new
custom_aggregation_unit = 'custom_aggregation_unit_example' # String | Name of aggregation unit specified when sending the message. Case-sensitive. For example, `Promotion_a` and `Promotion_A` are regarded as different unit names. 
from = '20210301' # String | Start date of aggregation period.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9 
to = '20210301' # String | End date of aggregation period. The end date can be specified for up to 30 days later. For example, if the start date is 20210301, the latest end date is 20210331.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9 

begin
  
  result = api_instance.get_statistics_per_unit(custom_aggregation_unit, from, to)
  p result
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_statistics_per_unit: #{e}"
end
```

#### Using the get_statistics_per_unit_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetStatisticsPerUnitResponse>, Integer, Hash)> get_statistics_per_unit_with_http_info(custom_aggregation_unit, from, to)

```ruby
begin
  
  data, status_code, headers = api_instance.get_statistics_per_unit_with_http_info(custom_aggregation_unit, from, to)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetStatisticsPerUnitResponse>
rescue LINE::Client::Insight::ApiError => e
  puts "Error when calling InsightApi->get_statistics_per_unit_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **custom_aggregation_unit** | **String** | Name of aggregation unit specified when sending the message. Case-sensitive. For example, &#x60;Promotion_a&#x60; and &#x60;Promotion_A&#x60; are regarded as different unit names.  |  |
| **from** | **String** | Start date of aggregation period.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9  |  |
| **to** | **String** | End date of aggregation period. The end date can be specified for up to 30 days later. For example, if the start date is 20210301, the latest end date is 20210331.  Format: yyyyMMdd (e.g. 20210301) Time zone: UTC+9  |  |

### Return type

[**GetStatisticsPerUnitResponse**](GetStatisticsPerUnitResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

