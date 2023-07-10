# LINE::Client::ManageAudience::ManageAudienceBlobApi

All URIs are relative to *https://api.line.me*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**add_user_ids_to_audience**](ManageAudienceBlobApi.md#add_user_ids_to_audience) | **PUT** /v2/bot/audienceGroup/upload/byFile |  |
| [**create_audience_for_uploading_user_ids**](ManageAudienceBlobApi.md#create_audience_for_uploading_user_ids) | **POST** /v2/bot/audienceGroup/upload/byFile |  |


## add_user_ids_to_audience

> add_user_ids_to_audience(file, opts)



Add user IDs or Identifiers for Advertisers (IFAs) to an audience for uploading user IDs (by file).

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceBlobApi.new
file = File.new('/path/to/some/file') # File | A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000 
opts = {
  audience_group_id: 789, # Integer | The audience ID.
  upload_description: 'upload_description_example' # String | The description to register with the job
}

begin
  
  api_instance.add_user_ids_to_audience(file, opts)
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceBlobApi->add_user_ids_to_audience: #{e}"
end
```

#### Using the add_user_ids_to_audience_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> add_user_ids_to_audience_with_http_info(file, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.add_user_ids_to_audience_with_http_info(file, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceBlobApi->add_user_ids_to_audience_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **file** | **File** | A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000  |  |
| **audience_group_id** | **Integer** | The audience ID. | [optional] |
| **upload_description** | **String** | The description to register with the job | [optional] |

### Return type

nil (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: multipart/form-data
- **Accept**: Not defined


## create_audience_for_uploading_user_ids

> <CreateAudienceGroupResponse> create_audience_for_uploading_user_ids(file, opts)



Create audience for uploading user IDs (by file).

### Examples

```ruby
require 'time'
require 'line_client_manage_audience'
# setup authorization
LINE::Client::ManageAudience.configure do |config|
  # Configure Bearer authorization: Bearer
  config.access_token = 'YOUR_BEARER_TOKEN'
end

api_instance = LINE::Client::ManageAudience::ManageAudienceBlobApi.new
file = File.new('/path/to/some/file') # File | A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000 
opts = {
  description: 'description_example', # String | The audience's name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120 
  is_ifa_audience: true, # Boolean | To specify recipients by IFAs: set `true`. To specify recipients by user IDs: set `false` or omit isIfaAudience property. 
  upload_description: 'upload_description_example' # String | The description to register for the job (in `jobs[].description`). 
}

begin
  
  result = api_instance.create_audience_for_uploading_user_ids(file, opts)
  p result
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceBlobApi->create_audience_for_uploading_user_ids: #{e}"
end
```

#### Using the create_audience_for_uploading_user_ids_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CreateAudienceGroupResponse>, Integer, Hash)> create_audience_for_uploading_user_ids_with_http_info(file, opts)

```ruby
begin
  
  data, status_code, headers = api_instance.create_audience_for_uploading_user_ids_with_http_info(file, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CreateAudienceGroupResponse>
rescue LINE::Client::ManageAudience::ApiError => e
  puts "Error when calling ManageAudienceBlobApi->create_audience_for_uploading_user_ids_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **file** | **File** | A text file with one user ID or IFA entered per line. Specify text/plain as Content-Type. Max file number: 1 Max number: 1,500,000  |  |
| **description** | **String** | The audience&#39;s name. This is case-insensitive, meaning AUDIENCE and audience are considered identical. Max character limit: 120  | [optional] |
| **is_ifa_audience** | **Boolean** | To specify recipients by IFAs: set &#x60;true&#x60;. To specify recipients by user IDs: set &#x60;false&#x60; or omit isIfaAudience property.  | [optional] |
| **upload_description** | **String** | The description to register for the job (in &#x60;jobs[].description&#x60;).  | [optional] |

### Return type

[**CreateAudienceGroupResponse**](CreateAudienceGroupResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

- **Content-Type**: multipart/form-data
- **Accept**: application/json

