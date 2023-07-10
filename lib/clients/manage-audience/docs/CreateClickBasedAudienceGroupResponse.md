# LINE::Client::ManageAudience::CreateClickBasedAudienceGroupResponse

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **audience_group_id** | **Integer** | The audience ID. | [optional] |
| **type** | [**AudienceGroupType**](AudienceGroupType.md) |  | [optional] |
| **description** | **String** | The audience&#39;s name. | [optional] |
| **created** | **Integer** | When the audience was created (in UNIX time). | [optional] |
| **request_id** | **String** | The request ID that was specified when the audience was created. | [optional] |
| **click_url** | **String** | The URL that was specified when the audience was created. | [optional] |
| **create_route** | **String** | How the audience was created. &#x60;MESSAGING_API&#x60;: An audience created with Messaging API.  | [optional] |
| **permission** | **String** | Audience&#39;s update permission. Audiences linked to the same channel will be READ_WRITE.  - &#x60;READ&#x60;: Can use only. - &#x60;READ_WRITE&#x60;: Can use and update.  | [optional] |
| **expire_timestamp** | **Integer** | Time of audience expiration. Only returned for specific audiences. | [optional] |
| **is_ifa_audience** | **Boolean** | The value indicating the type of account to be sent, as specified when creating the audience for uploading user IDs. One of:  true: Accounts are specified with IFAs. false (default): Accounts are specified with user IDs.  | [optional][default to false] |

## Example

```ruby
require 'line_client_manage_audience'

instance = LINE::Client::ManageAudience::CreateClickBasedAudienceGroupResponse.new(
  audience_group_id: null,
  type: null,
  description: null,
  created: null,
  request_id: null,
  click_url: null,
  create_route: null,
  permission: null,
  expire_timestamp: null,
  is_ifa_audience: null
)
```

