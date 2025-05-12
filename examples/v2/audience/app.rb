require 'line-bot-api'

def client
  @client ||= Line::Bot::V2::ManageAudience::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def blob_client
  @blob_client ||= Line::Bot::V2::ManageAudience::ApiBlobClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def api_client
  @api_client ||= Line::Bot::V2::MessagingApi::ApiClient.new(
    channel_access_token: ENV.fetch("LINE_CHANNEL_ACCESS_TOKEN"),
  )
end

def main
  audience_group_id = create_audience_group

  add_audience_by_ids(audience_group_id: audience_group_id)
  add_audience_by_file(audience_group_id: audience_group_id)

  audience_ready?(audience_group_id: audience_group_id)

  if audience_ready?(audience_group_id: audience_group_id)
    push_narrowcast(audience_group_id: audience_group_id)
  end

  delete_audience_group(audience_group_id: audience_group_id)
end

def create_audience_group
  request = Line::Bot::V2::ManageAudience::CreateAudienceGroupRequest.new(
    description: "audience_group_#{Time.now.to_i}",
  )
  response = client.create_audience_group(create_audience_group_request: request)

  if response.is_a?(Line::Bot::V2::ManageAudience::CreateAudienceGroupResponse)
    puts '=== Create audience success fully ==='
    puts "audience_group_id: #{response.audience_group_id}"
    puts "description: #{response.description}"

    response.audience_group_id
  else
    nil
  end
end

def add_audience_by_ids(audience_group_id:)
  request = Line::Bot::V2::ManageAudience::AddAudienceToAudienceGroupRequest.new(
    audience_group_id: audience_group_id,
    audiences: [
      Line::Bot::V2::ManageAudience::Audience.new(
        id: 'U1234567890abcdef1234567890abcdef' # TODO: replace with your user ID
      )
    ]
  )
  _body, status_code, _http_headers  = client.add_audience_to_audience_group_with_http_info(add_audience_to_audience_group_request: request)

  if status_code == 202
    puts '=== Add audience by IDs successfully ==='
  else
    puts '=== Add audience by IDs failed ==='
  end
end

def add_audience_by_file(audience_group_id:)
  # TODO: replace with your user ID in audience.txt
  File.open('audience.txt', 'r') do |f|
    _body, status_code, _http_headers = blob_client.add_user_ids_to_audience_with_http_info(
      audience_group_id: audience_group_id,
      file: f
    )

    if status_code == 202
      puts '=== Add audience by IDs successfully ==='
    else
      puts '=== Add audience by IDs failed ==='
    end
  end
end

def audience_ready?(audience_group_id:)
  response = client.get_audience_data(audience_group_id: audience_group_id)

  if response.is_a?(Line::Bot::V2::ManageAudience::GetAudienceDataResponse)
    status = response.audience_group&.status

    if status
      puts "=== Audience##{audience_group_id} status: #{status} ==="
      status == 'READY'
    else
      false
    end
  else
    false
  end
end

def delete_audience_group(audience_group_id:)
  _body, status_code, _http_headers = client.delete_audience_group_with_http_info(audience_group_id: audience_group_id)

  if status_code == 202
    puts '=== Delete audience group successfully ==='
  else
    puts '=== Delete audience group failed ==='
  end
end

def push_narrowcast(audience_group_id:)
  request = Line::Bot::V2::MessagingApi::NarrowcastRequest.new(
    messages: [
      Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello, this is a narrowcast message')
    ],
    recipient: Line::Bot::V2::MessagingApi::AudienceRecipient.new(
      audience_group_id: audience_group_id,
    )
  )
  _body, status_code, _http_headers = api_client.narrowcast_with_http_info(narrowcast_request: request)

  if status_code == 202
    puts '=== Push narrowcast successfully ==='
  else
    puts '=== Push narrowcast failed ==='
  end
rescue => e
  puts e.message
end

main
