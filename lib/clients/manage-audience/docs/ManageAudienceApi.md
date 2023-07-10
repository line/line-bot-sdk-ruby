# LINE::Client::ManageAudience::ManageAudienceApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**activate_audience_group**](ManageAudienceApi.md#activate_audience_group) | **PUT** /v2/bot/audienceGroup/{audienceGroupId}/activate |  |
| [**add_audience_to_audience_group**](ManageAudienceApi.md#add_audience_to_audience_group) | **PUT** /v2/bot/audienceGroup/upload |  |
| [**create_audience_group**](ManageAudienceApi.md#create_audience_group) | **POST** /v2/bot/audienceGroup/upload |  |
| [**create_click_based_audience_group**](ManageAudienceApi.md#create_click_based_audience_group) | **POST** /v2/bot/audienceGroup/click |  |
| [**create_imp_based_audience_group**](ManageAudienceApi.md#create_imp_based_audience_group) | **POST** /v2/bot/audienceGroup/imp |  |
| [**delete_audience_group**](ManageAudienceApi.md#delete_audience_group) | **DELETE** /v2/bot/audienceGroup/{audienceGroupId} |  |
| [**get_audience_data**](ManageAudienceApi.md#get_audience_data) | **GET** /v2/bot/audienceGroup/{audienceGroupId} |  |
| [**get_audience_group_authority_level**](ManageAudienceApi.md#get_audience_group_authority_level) | **GET** /v2/bot/audienceGroup/authorityLevel |  |
| [**get_audience_groups**](ManageAudienceApi.md#get_audience_groups) | **GET** /v2/bot/audienceGroup/list |  |
| [**update_audience_group_authority_level**](ManageAudienceApi.md#update_audience_group_authority_level) | **PUT** /v2/bot/audienceGroup/authorityLevel |  |
| [**update_audience_group_description**](ManageAudienceApi.md#update_audience_group_description) | **PUT** /v2/bot/audienceGroup/{audienceGroupId}/updateDescription |  |


## activate_audience_group

> activate_audience_group(audience_group_id)



Activate audience

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
audience_group_id = 789 # Integer | The audience ID.

begin
  
  api_instance.activate_audience_group(audience_group_id)
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->activate_audience_group: #{e}"
end
```

#### Using the activate_audience_group_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> activate_audience_group_with_http_info(audience_group_id)

```ruby
begin
  
  data, status_code, headers = api_instance.activate_audience_group_with_http_info(audience_group_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->activate_audience_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## add_audience_to_audience_group

> add_audience_to_audience_group(add_audience_to_audience_group_request)



Add user IDs or Identifiers for Advertisers (IFAs) to an audience for uploading user IDs (by JSON)

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
add_audience_to_audience_group_request = LINE::Client::ManageAudience::AddAudienceToAudienceGroupRequest.new # AddAudienceToAudienceGroupRequest | 

begin
  
  api_instance.add_audience_to_audience_group(add_audience_to_audience_group_request)
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->add_audience_to_audience_group: #{e}"
end
```

#### Using the add_audience_to_audience_group_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> add_audience_to_audience_group_with_http_info(add_audience_to_audience_group_request)

```ruby
begin
  
  data, status_code, headers = api_instance.add_audience_to_audience_group_with_http_info(add_audience_to_audience_group_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->add_audience_to_audience_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **add_audience_to_audience_group_request** | [**AddAudienceToAudienceGroupRequest**](AddAudienceToAudienceGroupRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## create_audience_group

> <CreateAudienceGroupResponse> create_audience_group(create_audience_group_request)



Create audience for uploading user IDs (by JSON)

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
create_audience_group_request = LINE::Client::ManageAudience::CreateAudienceGroupRequest.new # CreateAudienceGroupRequest | 

begin
  
  result = api_instance.create_audience_group(create_audience_group_request)
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->create_audience_group: #{e}"
end
```

#### Using the create_audience_group_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateAudienceGroupResponse>, Integer, Hash)> create_audience_group_with_http_info(create_audience_group_request)

```ruby
begin
  
  data, status_code, headers = api_instance.create_audience_group_with_http_info(create_audience_group_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateAudienceGroupResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->create_audience_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_audience_group_request** | [**CreateAudienceGroupRequest**](CreateAudienceGroupRequest.md) |  |  |

### Return type

[**CreateAudienceGroupResponse**](CreateAudienceGroupResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_click_based_audience_group

> <CreateClickBasedAudienceGroupResponse> create_click_based_audience_group(create_click_based_audience_group_request)



Create audience for click-based retargeting

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
create_click_based_audience_group_request = LINE::Client::ManageAudience::CreateClickBasedAudienceGroupRequest.new # CreateClickBasedAudienceGroupRequest | 

begin
  
  result = api_instance.create_click_based_audience_group(create_click_based_audience_group_request)
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->create_click_based_audience_group: #{e}"
end
```

#### Using the create_click_based_audience_group_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateClickBasedAudienceGroupResponse>, Integer, Hash)> create_click_based_audience_group_with_http_info(create_click_based_audience_group_request)

```ruby
begin
  
  data, status_code, headers = api_instance.create_click_based_audience_group_with_http_info(create_click_based_audience_group_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateClickBasedAudienceGroupResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->create_click_based_audience_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_click_based_audience_group_request** | [**CreateClickBasedAudienceGroupRequest**](CreateClickBasedAudienceGroupRequest.md) |  |  |

### Return type

[**CreateClickBasedAudienceGroupResponse**](CreateClickBasedAudienceGroupResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## create_imp_based_audience_group

> <CreateImpBasedAudienceGroupResponse> create_imp_based_audience_group(create_imp_based_audience_group_request)



Create audience for impression-based retargeting

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
create_imp_based_audience_group_request = LINE::Client::ManageAudience::CreateImpBasedAudienceGroupRequest.new # CreateImpBasedAudienceGroupRequest | 

begin
  
  result = api_instance.create_imp_based_audience_group(create_imp_based_audience_group_request)
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->create_imp_based_audience_group: #{e}"
end
```

#### Using the create_imp_based_audience_group_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateImpBasedAudienceGroupResponse>, Integer, Hash)> create_imp_based_audience_group_with_http_info(create_imp_based_audience_group_request)

```ruby
begin
  
  data, status_code, headers = api_instance.create_imp_based_audience_group_with_http_info(create_imp_based_audience_group_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateImpBasedAudienceGroupResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->create_imp_based_audience_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **create_imp_based_audience_group_request** | [**CreateImpBasedAudienceGroupRequest**](CreateImpBasedAudienceGroupRequest.md) |  |  |

### Return type

[**CreateImpBasedAudienceGroupResponse**](CreateImpBasedAudienceGroupResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_audience_group

> delete_audience_group(audience_group_id)



Delete audience

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
audience_group_id = 789 # Integer | The audience ID.

begin
  
  api_instance.delete_audience_group(audience_group_id)
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->delete_audience_group: #{e}"
end
```

#### Using the delete_audience_group_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_audience_group_with_http_info(audience_group_id)

```ruby
begin
  
  data, status_code, headers = api_instance.delete_audience_group_with_http_info(audience_group_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->delete_audience_group_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: Not defined


## get_audience_data

> <GetAudienceDataResponse> get_audience_data(audience_group_id)



Gets audience data.

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
audience_group_id = 789 # Integer | The audience ID.

begin
  
  result = api_instance.get_audience_data(audience_group_id)
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->get_audience_data: #{e}"
end
```

#### Using the get_audience_data_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAudienceDataResponse>, Integer, Hash)> get_audience_data_with_http_info(audience_group_id)

```ruby
begin
  
  data, status_code, headers = api_instance.get_audience_data_with_http_info(audience_group_id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAudienceDataResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->get_audience_data_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. |  |

### Return type

[**GetAudienceDataResponse**](GetAudienceDataResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_audience_group_authority_level

> <GetAudienceGroupAuthorityLevelResponse> get_audience_group_authority_level



Get the authority level of the audience

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new

begin
  
  result = api_instance.get_audience_group_authority_level
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->get_audience_group_authority_level: #{e}"
end
```

#### Using the get_audience_group_authority_level_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAudienceGroupAuthorityLevelResponse>, Integer, Hash)> get_audience_group_authority_level_with_http_info

```ruby
begin
  
  data, status_code, headers = api_instance.get_audience_group_authority_level_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAudienceGroupAuthorityLevelResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->get_audience_group_authority_level_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetAudienceGroupAuthorityLevelResponse**](GetAudienceGroupAuthorityLevelResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_audience_groups

> <GetAudienceGroupsResponse> get_audience_groups(page, description, status, size, includes_external_public_groups, create_route)



Gets data for more than one audience.

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
page = 789 # Integer | The page to return when getting (paginated) results. Must be 1 or higher.
description = 'description_example' # String | The name of the audience(s) to return. You can search for partial matches. This is case-insensitive, meaning AUDIENCE and audience are considered identical. If omitted, the name of the audience(s) will not be used as a search criterion. 
status = LINE::Client::ManageAudience::AudienceGroupStatus::IN_PROGRESS # AudienceGroupStatus | The status of the audience(s) to return. If omitted, the status of the audience(s) will not be used as a search criterion. 
size = 20 # Integer | The number of audiences per page. Default: 20 Max: 40 
includes_external_public_groups = true # Boolean | true (default): Get public audiences created in all channels linked to the same bot. false: Get audiences created in the same channel. 
create_route = LINE::Client::ManageAudience::AudienceGroupCreateRoute::OA_MANAGER # AudienceGroupCreateRoute | How the audience was created. If omitted, all audiences are included.  `OA_MANAGER`: Return only audiences created with LINE Official Account Manager (opens new window). `MESSAGING_API`: Return only audiences created with Messaging API. 

begin
  
  result = api_instance.get_audience_groups(page, description, status, size, includes_external_public_groups, create_route)
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->get_audience_groups: #{e}"
end
```

#### Using the get_audience_groups_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAudienceGroupsResponse>, Integer, Hash)> get_audience_groups_with_http_info(page, description, status, size, includes_external_public_groups, create_route)

```ruby
begin
  
  data, status_code, headers = api_instance.get_audience_groups_with_http_info(page, description, status, size, includes_external_public_groups, create_route)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAudienceGroupsResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->get_audience_groups_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **page** | **Integer** | The page to return when getting (paginated) results. Must be 1 or higher. |  |
| **description** | **String** | The name of the audience(s) to return. You can search for partial matches. This is case-insensitive, meaning AUDIENCE and audience are considered identical. If omitted, the name of the audience(s) will not be used as a search criterion.  |  |
| **status** | [**AudienceGroupStatus**](.md) | The status of the audience(s) to return. If omitted, the status of the audience(s) will not be used as a search criterion.  |  |
| **size** | **Integer** | The number of audiences per page. Default: 20 Max: 40  |  |
| **includes_external_public_groups** | **Boolean** | true (default): Get public audiences created in all channels linked to the same bot. false: Get audiences created in the same channel.  |  |
| **create_route** | [**AudienceGroupCreateRoute**](.md) | How the audience was created. If omitted, all audiences are included.  &#x60;OA_MANAGER&#x60;: Return only audiences created with LINE Official Account Manager (opens new window). &#x60;MESSAGING_API&#x60;: Return only audiences created with Messaging API.  |  |

### Return type

[**GetAudienceGroupsResponse**](GetAudienceGroupsResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_audience_group_authority_level

> update_audience_group_authority_level(update_audience_group_authority_level_request)



Change the authority level of the audience

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
update_audience_group_authority_level_request = LINE::Client::ManageAudience::UpdateAudienceGroupAuthorityLevelRequest.new # UpdateAudienceGroupAuthorityLevelRequest | 

begin
  
  api_instance.update_audience_group_authority_level(update_audience_group_authority_level_request)
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->update_audience_group_authority_level: #{e}"
end
```

#### Using the update_audience_group_authority_level_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> update_audience_group_authority_level_with_http_info(update_audience_group_authority_level_request)

```ruby
begin
  
  data, status_code, headers = api_instance.update_audience_group_authority_level_with_http_info(update_audience_group_authority_level_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->update_audience_group_authority_level_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **update_audience_group_authority_level_request** | [**UpdateAudienceGroupAuthorityLevelRequest**](UpdateAudienceGroupAuthorityLevelRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined


## update_audience_group_description

> update_audience_group_description(audience_group_id, update_audience_group_description_request)



Renames an existing audience.

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceApi.new
audience_group_id = 789 # Integer | The audience ID.
update_audience_group_description_request = LINE::Client::ManageAudience::UpdateAudienceGroupDescriptionRequest.new # UpdateAudienceGroupDescriptionRequest | 

begin
  
  api_instance.update_audience_group_description(audience_group_id, update_audience_group_description_request)
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->update_audience_group_description: #{e}"
end
```

#### Using the update_audience_group_description_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> update_audience_group_description_with_http_info(audience_group_id, update_audience_group_description_request)

```ruby
begin
  
  data, status_code, headers = api_instance.update_audience_group_description_with_http_info(audience_group_id, update_audience_group_description_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceApi->update_audience_group_description_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. |  |
| **update_audience_group_description_request** | [**UpdateAudienceGroupDescriptionRequest**](UpdateAudienceGroupDescriptionRequest.md) |  |  |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: Not defined

