# typed: true

require 'line/bot'

# Type-level sanity check for the unified v2 client surface.
# This file is intentionally not executed in runtime tests; it exists so
# `steep check` fails when public API usage drifts from expected typing.
client = Line::Bot::V2::LineBotClient.new(channel_access_token: 'token')

profile = client.get_profile(user_id: 'U1234567890')
if profile.is_a?(Line::Bot::V2::MessagingApi::UserProfileResponse)
  profile.user_id
end

client.get_audience_groups(
  page: 1,
  includes_external_public_groups: true
)

push_request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
  to: 'U1234567890',
  messages: [Line::Bot::V2::MessagingApi::TextMessage.new(text: 'hello')]
)
client.push_message(push_message_request: push_request)
