require 'spec_helper'

describe 'MessagingApi::ApiClient' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

  describe 'GET /v2/bot/message/progress/narrowcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_body) do
      # missing errorCode, completedTime, targetCount
      {
        "phase" => "waiting",
        "acceptedTime" => "2020-12-03T10:15:30.121Z"
      }
        .to_json
    end
    let(:response_code) { 200 }

    it 'no problem even when response does not contain some JSON keys' do
      stub_request(:get, "https://api.line.me/v2/bot/message/progress/narrowcast?requestId=7d51557c-7ba0-4ed7-991f-36b2a340dc1a")
        .with(
          headers: {
            'Authorization' => 'Bearer YOUR_CHANNEL_ACCESS_TOKEN',
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'x-line-request-id' => '3a785346-2cf3-482f-8469-c893117fcef8' })

      body, status_code, headers = client.get_narrowcast_progress_with_http_info(
        request_id: '7d51557c-7ba0-4ed7-991f-36b2a340dc1a'
      )

      expect(status_code).to eq(200)
      expect(body.phase).to eq('waiting')
      expect(body.accepted_time).to eq('2020-12-03T10:15:30.121Z')
      expect(body.error_code).to be_nil
      expect(body.completed_time).to be_nil
      expect(body.target_count).to be_nil
    end
  end

  describe 'GET /v2/bot/followers/ids' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_code) { 200 }

    context 'when no optional parameters given' do
      it 'returns a list of followers successfully (strict check without any query params)' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"] }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            },
            query: {}
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_followers_with_http_info

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
      end
    end

    context 'when only start parameter is given' do
      it 'returns a list of followers with next token (strict check with only "start")' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "start" => "from previous NEXT" }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT")

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
        expect(body._next).to eq("nExT Token")
      end
    end

    context 'when limit and start parameters are both given' do
      it 'returns a list of followers with next token (strict check with "limit" and "start")' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"], "next" => "nExT Token" }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "limit" => "10", "start" => "from previous NEXT" }
          )
          .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, headers = client.get_followers_with_http_info(start: "from previous NEXT", limit: 10)

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
        expect(body._next).to eq("nExT Token")
      end
    end

    context 'when making two consecutive requests in one test' do
      it 'handles two requests, first with the same params and second with different params' do
        first_response_body = {
          "userIds" => ["U1111111111", "U2222222222"],
          "next" => "firstNextToken"
        }.to_json
        second_response_body = {
          "userIds" => ["U3333333333", "U4444444444"],
        }.to_json

        # First request: using start="from previous NEXT", limit=10
        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "start" => "from previous NEXT", "limit" => "10" }
          )
          .to_return(
            status: 200,
            body: first_response_body,
            headers: { 'Content-Type' => 'application/json' }
          )

        # Second request: using start="anotherParam", limit=5
        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer test-channel-access-token" },
            query: { "start" => "anotherParam", "limit" => "5" }
          )
          .to_return(
            status: 200,
            body: second_response_body,
            headers: { 'Content-Type' => 'application/json' }
          )

        # ---- First access ----
        body1, status_code1, headers1 = client.get_followers_with_http_info(start: "from previous NEXT", limit: 10)
        expect(status_code1).to eq(200)
        expect(body1.user_ids).to eq(["U1111111111", "U2222222222"])
        expect(body1._next).to eq("firstNextToken")

        # ---- Second access ----
        body2, status_code2, headers2 = client.get_followers_with_http_info(start: "anotherParam", limit: 5)
        expect(status_code2).to eq(200)
        expect(body2.user_ids).to eq(["U3333333333", "U4444444444"])
        expect(body2._next).to be_nil
      end
    end
  end

  describe 'POST /v2/bot/message/push' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) do
      {
        "sentMessages": [
          {
            "id": "461230966842064897",
            "quoteToken": "IStG5h1Tz7b..."
          }
        ]
      }.to_json
    end
    let(:response_code) { 200 }

    it 'response - success - using Line::Bot::V2::MessagingApi::PushMessageRequest' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => " Hello, world! "
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: ' Hello, world! '
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'response - success - using hash (not recommended way)', rbs_test: :skip do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => " Hello, world! "
              }
            ],
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = {
        "to" => "USER_ID",
        "messages" => [{ type: 'text', text: ' Hello, world! ' }]
      }
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
    end

    it 'request - text message v2' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "textV2",
                "text" => " Hello, world! {user_name} san!",
                "substitution" => {
                  "user_name" => {
                    "type" => "mention",
                    "mentionee" => {
                      "type" => "user",
                      "userId" => "U1234567890"
                    }
                  }
                }
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessageV2.new(
            text: ' Hello, world! {user_name} san!',
            substitution: {
              user_name: Line::Bot::V2::MessagingApi::MentionSubstitutionObject.new(
                mentionee: Line::Bot::V2::MessagingApi::UserMentionTarget.new(
                  user_id: 'U1234567890'
                )
              )
            }
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'request - coupon message' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "coupon",
                "couponId" => "COUPON_ID_1"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::CouponMessage.new(
            coupon_id: 'COUPON_ID_1'
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'request - success - flex message using request class from JSON' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body:  {
            to: "U4af4980629...",
            messages: [
              {
                type: "flex",
                altText: "This is a Flex Message",
                contents: {
                  type: "bubble",
                  body: {
                    type: "box",
                    layout: "horizontal",
                    contents: [
                      {
                        type: "text",
                        text: "Hello"
                      }
                    ]
                  }
                }
              }
            ],
            notificationDisabled: false
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.create(
        JSON.parse(
          <<~JSON
            {
              "to": "U4af4980629...",
              "messages": [
                {
                  "type": "flex",
                  "alt_text": "This is a Flex Message",
                  "contents": {
                    "type": "bubble",
                    "body": {
                      "type": "box",
                      "layout": "horizontal",
                      "contents": [
                        {
                          "type": "text",
                          "text": "Hello"
                        }
                      ]
                    }
                  }
                }
              ]
            }
          JSON
        )
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'requees with custom aggregation unit that contains underscore' do
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => " Hello, world! b_a san!",
                "customAggregationUnits" => [
                  "aa_bb_11"
                ]
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: ' Hello, world! b_a san!',
            custom_aggregation_units: [
              'aa_bb_11'
            ]
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(push_message_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'request with x_line_retry_key: nil' do
      client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token-retry-key-nil')
      retry_key = nil
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token-retry-key-nil",
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      client.push_message_with_http_info(
        push_message_request: request,
        x_line_retry_key: retry_key
      )

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/bot/message/push")
                           .with { |req| !req.headers.key?("X-Line-Retry-Key") })
    end

    it 'request with x-line-retry-key header - success' do
      retry_key = 'f03c3eb4-0267-4080-9e65-fffa184e1933'
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(
        push_message_request: request,
        x_line_retry_key: retry_key
      )
      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
    end

    it 'request with  x-line-retry-key header - conflicted' do
      retry_key = '2a6e07b0-0fcf-439f-908b-828ed527e882'
      request_id = '3a785346-2cf3-482f-8469-c893117fcef8'
      accepted_request_id = '4a6e07b0-0fcf-439f-908b-828ed527e882'

      error_response_body = {
        "message" => "The retry key is already accepted",
        "sentMessages" => [
          {
            "id" => "461230966842064897",
            "quoteToken" => "IStG5h1Tz7b..."
          }
        ]
      }.to_json
      error_response_headers = {
        'Content-Type' => 'application/json',
        'x-line-request-id' => request_id,
        'x-line-accepted-request-id' => accepted_request_id
      }
      stub_request(:post, "https://api.line.me/v2/bot/message/push")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          },
          body: {
            "to" => "USER_ID",
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: 409, body: error_response_body, headers: error_response_headers)

      request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
        to: 'USER_ID',
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.push_message_with_http_info(
        push_message_request: request,
        x_line_retry_key: retry_key
      )
      expect(status_code).to eq(409)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::ErrorResponse)
      expect(body.message).to eq("The retry key is already accepted")
      expect(body.sent_messages).to be_a(Array)
      expect(body.sent_messages[0]).to be_a(Line::Bot::V2::MessagingApi::SentMessage)
      expect(body.sent_messages[0].id).to eq('461230966842064897')
      expect(body.sent_messages[0].quote_token).to eq('IStG5h1Tz7b...')
      expect(headers['x-line-request-id']).to eq(request_id)
      expect(headers['x-line-accepted-request-id']).to eq(accepted_request_id)
    end
  end

  describe 'POST /v2/bot/message/broadcast' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { {}.to_json } # empty json
    let(:response_code) { 200 }

    it 'empty json as response body should not throw error' do
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: {
            "messages" => [
              {
                "type" => "text",
                "text" => "Hello, world!"
              }
            ],
            "notificationDisabled" => false,
          }.to_json
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )

      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: request)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end

    it 'request with x_line_retry_key: nil' do
      client = Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token-retry-key-nil')
      retry_key = nil
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token-retry-key-nil",
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      client.broadcast_with_http_info(broadcast_request: request, x_line_retry_key: retry_key)

      expect(WebMock).to(have_requested(:post, "https://api.line.me/v2/bot/message/broadcast")
                           .with { |req| !req.headers.key?("X-Line-Retry-Key") })
    end

    it 'request with  x-line-retry-key header - success' do
      retry_key = 'f03c3eb4-0267-4080-9e65-fffa184e1933'
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: request, x_line_retry_key: retry_key)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end

    it 'request with  x-line-retry-key header - conflicted' do
      retry_key = '2a6e07b0-0fcf-439f-908b-828ed527e882'
      request_id = '3a785346-2cf3-482f-8469-c893117fcef8'
      accepted_request_id = '4a6e07b0-0fcf-439f-908b-828ed527e882'

      error_response_body = { "message" => "The retry key is already accepted" }.to_json
      error_response_headers = {
        'Content-Type' => 'application/json',
        'x-line-request-id' => request_id,
        'x-line-accepted-request-id' => accepted_request_id
      }
      stub_request(:post, "https://api.line.me/v2/bot/message/broadcast")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token",
            'X-Line-Retry-Key' => retry_key
          }
        )
        .to_return(status: 409, body: error_response_body, headers: error_response_headers)

      request = Line::Bot::V2::MessagingApi::BroadcastRequest.new(
        messages: [
          Line::Bot::V2::MessagingApi::TextMessage.new(
            text: 'Hello, world!'
          )
        ]
      )
      body, status_code, headers = client.broadcast_with_http_info(broadcast_request: request, x_line_retry_key: retry_key)

      expect(status_code).to eq(409)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::ErrorResponse)
      expect(body.message).to eq("The retry key is already accepted")
      expect(headers['x-line-request-id']).to eq(request_id)
      expect(headers['x-line-accepted-request-id']).to eq(accepted_request_id)
    end
  end

  describe 'GET /v2/bot/message/aggregation/list' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) { { "customAggregationUnits" => ["unit1", "unit2"], "next" => "token" }.to_json }
    let(:response_code) { 200 }

    it 'returns a list of aggregation units successfully without optional parameters' do
      stub_request(:get, "https://api.line.me/v2/bot/message/aggregation/list")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_aggregation_unit_name_list_with_http_info

      expect(status_code).to eq(200)
      expect(body.custom_aggregation_units).to eq(["unit1", "unit2"])
      expect(body._next).to eq("token")
    end
  end

  describe 'Same endpoint but different HTTP method' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:rich_menu_id) { "richmenuid" }

    describe 'GET /v2/bot/user/all/richmenu' do
      let(:response_body) { { richMenuId: rich_menu_id }.to_json }
      let(:response_code) { 200 }

      it 'returns a default rich menu ID successfully' do
        stub_request(:get, "https://api.line.me/v2/bot/user/all/richmenu")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: response_body, headers: {})

        body, status_code, headers = client.get_default_rich_menu_id_with_http_info

        expect(status_code).to eq(response_code)
        expect(body.rich_menu_id).to eq(rich_menu_id)
      end
    end

    describe 'POST /v2/bot/user/all/richmenu' do
      let(:response_body) { {}.to_json }
      let(:response_code) { 200 }

      it 'sets the default rich menu successfully' do
        stub_request(:post, "https://api.line.me/v2/bot/user/all/richmenu/#{rich_menu_id}")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: '{}', headers: {})

        body, status_code, headers = client.set_default_rich_menu_with_http_info(rich_menu_id: rich_menu_id)

        expect(status_code).to eq(response_code)
        expect(body).to eq(response_body)
      end
    end

    describe 'DELETE /v2/bot/user/all/richmenu' do
      let(:response_body) { {}.to_json }
      let(:response_code) { 200 }

      it 'deletes the default rich menu successfully' do
        stub_request(:delete, "https://api.line.me/v2/bot/user/all/richmenu")
          .with(
            headers: {
              'Authorization' => "Bearer test-channel-access-token"
            }
          )
          .to_return(status: response_code, body: '{}', headers: {})

        # Call the API method
        body, status_code, headers = client.cancel_default_rich_menu_with_http_info

        # Assertions
        expect(status_code).to eq(200)
        expect(body).to eq(response_body)
      end
    end
  end

  describe 'POST /v2/bot/user/{userId}/richmenu/{richMenuId}' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    it 'path parameter works (string)' do
      user_id = 'U1234567890'
      rich_menu_id = 'richmenu-1234567890-bba-222'

      stub_request(:post, "https://api.line.me/v2/bot/user/U1234567890/richmenu/richmenu-1234567890-bba-222")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          }
        )
        .to_return(status: 200, body: '{}', headers: {})

      body, status_code, headers = client.link_rich_menu_id_to_user_with_http_info(user_id: user_id, rich_menu_id: rich_menu_id)

      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end
  end

  describe 'POST /v2/bot/coupon' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:response_body) do
      {
        "couponId": "01JWZKMV..."
      }.to_json
    end
    let(:response_code) { 200 }

    it 'creates a coupon with correct parameters' do
      expected_body = {
        title: "100Yen OFF",
        startTimestamp: 1751619750,
        endTimestamp: 1751619751,
        visibility: "PUBLIC",
        maxUseCountPerTicket: 1,
        timezone: "ASIA_TOKYO",
        reward: {
          type: "discount",
          priceInfo: {
            type: "fixed",
            fixedAmount: 100
          }
        },
        acquisitionCondition: {
          type: "lottery",
          lotteryProbability: 50,
          maxAcquireCount: 1
        }
      }

      stub_request(:post, "https://api.line.me/v2/bot/coupon")
        .with(
          headers: {
            'Authorization' => "Bearer test-channel-access-token"
          },
          body: hash_including(expected_body)
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      request = Line::Bot::V2::MessagingApi::CouponCreateRequest.new(
        title: '100Yen OFF',
        start_timestamp: 1751619750,
        end_timestamp: 1751619751,
        visibility: 'PUBLIC',
        max_use_count_per_ticket: 1,
        timezone: 'ASIA_TOKYO',
        reward: Line::Bot::V2::MessagingApi::CouponDiscountRewardRequest.new(
          price_info: Line::Bot::V2::MessagingApi::DiscountFixedPriceInfoRequest.new(
            fixed_amount: 100
          )
        ),
        acquisition_condition: Line::Bot::V2::MessagingApi::LotteryAcquisitionConditionRequest.new(
          lottery_probability: 50,
          max_acquire_count: 1
        )
      )
      body, status_code, headers = client.create_coupon_with_http_info(coupon_create_request: request)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::CouponCreateResponse)
      expect(body.coupon_id).to eq('01JWZKMV...')
    end
  end

  describe 'PUT /v2/bot/coupon/{couponId}/close' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:coupon_id) { '01JWZKMV...' }
    let(:response_body) { {}.to_json }
    let(:response_code) { 200 }
    it 'path parameter works (string)' do
      stub_request(:put, "https://api.line.me/v2/bot/coupon/#{coupon_id}/close")
        .with(
          headers: { 'Authorization' => "Bearer test-channel-access-token" }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })
      body, status_code, headers = client.close_coupon_with_http_info(coupon_id: coupon_id)
      expect(status_code).to eq(200)
      expect(body).to eq("{}")
    end
  end

  describe 'GET /v2/bot/coupon/{couponId}' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    let(:coupon_id) { '01JWZKMV...' }
    let(:response_body) do
      {
        "couponId": coupon_id,
        "title": "100Yen OFF",
        "startTimestamp": 1751619750,
        "endTimestamp": 1751619751,
        "visibility": "PUBLIC",
        "maxUseCountPerTicket": 1,
        "maxTicketPerUser": 1,
        "timezone": "ASIA_TOKYO",
        "reward": {
          "type": "discount",
          "priceInfo": {
            "type": "fixed",
            "fixedAmount": 100,
            "currency": "JPY"
          }
        },
        "acquisitionCondition": {
          "type": "lottery",
          "lotteryProbability": 50,
          "maxAcquireCount": 1
        },
        "status": "RUNNING",
        "createdTimestamp": 1751609750
      }.to_json
    end
    let(:response_code) { 200 }
    it 'path parameter works (string)' do
      stub_request(:get, "https://api.line.me/v2/bot/coupon/#{coupon_id}")
        .with(
          headers: { 'Authorization' => "Bearer test-channel-access-token" }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, headers = client.get_coupon_detail_with_http_info(coupon_id: coupon_id)

      expect(status_code).to eq(200)
      expect(body).to be_a(Line::Bot::V2::MessagingApi::CouponResponse)
      expect(body.coupon_id).to eq(coupon_id)
      expect(body.title).to eq("100Yen OFF")
      expect(body.start_timestamp).to eq(1751619750)
      expect(body.end_timestamp).to eq(1751619751)
      expect(body.visibility).to eq("PUBLIC")
      expect(body.max_use_count_per_ticket).to eq(1)
      expect(body.timezone).to eq("ASIA_TOKYO")
      expect(body.reward.type).to eq("discount")
      expect(body.reward.price_info.type).to eq("fixed")
      expect(body.reward.price_info.fixed_amount).to eq(100)
      expect(body.reward.price_info.currency).to eq("JPY")
      expect(body.acquisition_condition.type).to eq("lottery")
      expect(body.acquisition_condition.lottery_probability).to eq(50)
      expect(body.acquisition_condition.max_acquire_count).to eq(1)
      expect(body.status).to eq("RUNNING")
      expect(body.created_timestamp).to eq(1751609750)
    end
  end

  describe 'GET /v2/bot/coupon' do
    let(:client) { Line::Bot::V2::MessagingApi::ApiClient.new(channel_access_token: 'test-channel-access-token') }
    it 'query parameter is encoded' do
      first_response_body = {
        "items" => [
          {"couponId" => "COUPON_ID_1", "title" => "coupon 1"},
          {"couponId" => "COUPON_ID_2", "title" => "coupon 2"}
        ],
        "next" => "firstNextToken"
      }.to_json
      second_response_body = {
        "items" => [
          {"couponId" => "COUPON_ID_3", "title" => "coupon 3"},
          {"couponId" => "COUPON_ID_4", "title" => "coupon 4"}
        ],
      }.to_json

      # First request: using limit=2, status=CLOSED,RUNNING
      stub_request(:get, "https://api.line.me/v2/bot/coupon?limit=2&status=CLOSED,RUNNING")
        .with(
          headers: { 'Authorization' => "Bearer test-channel-access-token" }
        )
        .to_return(
          status: 200,
          body: first_response_body,
          headers: { 'Content-Type' => 'application/json' }
        )
      # Second request: using status=CLOSED,RUNNING, start="firstNextToken"
      stub_request(:get, "https://api.line.me/v2/bot/coupon?status=CLOSED,RUNNING&start=firstNextToken")
        .with(
          headers: { 'Authorization' => "Bearer test-channel-access-token" }
        )
        .to_return(
          status: 200,
          body: second_response_body,
          headers: { 'Content-Type' => 'application/json' }
        )

      # ---- First access ----
      body1, status_code1, headers1 = client.list_coupon_with_http_info(limit: 2, status: ["CLOSED", "RUNNING"])
      expect(status_code1).to eq(200)
      expect(body1.items).to be_a(Array)
      expect(body1.items[0].coupon_id).to eq("COUPON_ID_1")
      expect(body1.items[0].title).to eq("coupon 1")
      expect(body1.items[1].coupon_id).to eq("COUPON_ID_2")
      expect(body1.items[1].title).to eq("coupon 2")
      expect(body1._next).to eq("firstNextToken")

      # ---- Second access ----
      body2, status_code2, headers2 = client.list_coupon_with_http_info(status: ["CLOSED", "RUNNING"], start: "firstNextToken")
      expect(status_code2).to eq(200)
      expect(body2.items).to be_a(Array)
      expect(body2.items[0].coupon_id).to eq("COUPON_ID_3")
      expect(body2.items[0].title).to eq("coupon 3")
      expect(body2.items[1].coupon_id).to eq("COUPON_ID_4")
      expect(body2.items[1].title).to eq("coupon 4")
      expect(body2._next).to be_nil
    end
  end
end
