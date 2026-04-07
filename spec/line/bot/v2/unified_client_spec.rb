require 'spec_helper'

describe 'Line::Bot::V2::LineBotClient' do
  let(:channel_access_token) { 'test-channel-access-token' }
  let(:client) { Line::Bot::V2::LineBotClient.new(channel_access_token: channel_access_token) }

  describe '#initialize' do
    it 'raises TypeError when channel_access_token is nil', rbs_test: :skip do
      expect { Line::Bot::V2::LineBotClient.new(channel_access_token: nil) }.to raise_error(TypeError)
    end

    it 'raises TypeError when channel_access_token is empty' do
      expect { Line::Bot::V2::LineBotClient.new(channel_access_token: '') }.to raise_error(TypeError)
    end

    it 'creates a client with valid channel_access_token' do
      expect(client).to be_a(Line::Bot::V2::LineBotClient)
    end
  end

  describe 'Insight API delegation' do
    describe 'GET /v2/bot/insight/followers' do
      it 'returns the number of followers via unified client' do
        response_body = {
          "status" => "ready",
          "followers" => 1000,
          "targetedReaches" => 900,
          "blocks" => 100
        }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
          .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, = client.get_number_of_followers_with_http_info

        expect(status_code).to eq(200)
        expect(body).to be_a(Line::Bot::V2::Insight::GetNumberOfFollowersResponse)
        expect(body.status).to eq('ready')
        expect(body.followers).to eq(1000)
        expect(body.targeted_reaches).to eq(900)
        expect(body.blocks).to eq(100)
      end

      it 'also works without _with_http_info' do
        response_body = { "status" => "ready", "followers" => 500 }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
          .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body = client.get_number_of_followers

        expect(body).to be_a(Line::Bot::V2::Insight::GetNumberOfFollowersResponse)
        expect(body.followers).to eq(500)
      end
    end
  end

  describe 'MessagingApi delegation' do
    describe 'POST /v2/bot/message/push' do
      let(:push_response_body) do
        { "sentMessages": [{ "id": "461230966842064897", "quoteToken": "IStG5h1Tz7b..." }] }.to_json
      end

      it 'sends a push message via unified client' do
        stub_request(:post, "https://api.line.me/v2/bot/message/push")
          .with(
            headers: { 'Authorization' => "Bearer #{channel_access_token}" },
            body: {
              "to" => "USER_ID",
              "messages" => [{ "type" => "text", "text" => "Hello!" }],
              "notificationDisabled" => false
            }.to_json
          )
          .to_return(status: 200, body: push_response_body, headers: { 'Content-Type' => 'application/json' })

        request = Line::Bot::V2::MessagingApi::PushMessageRequest.new(
          to: 'USER_ID',
          messages: [Line::Bot::V2::MessagingApi::TextMessage.new(text: 'Hello!')]
        )
        body, status_code, = client.push_message_with_http_info(push_message_request: request)

        expect(status_code).to eq(200)
        expect(body).to be_a(Line::Bot::V2::MessagingApi::PushMessageResponse)
        expect(body.sent_messages[0].id).to eq('461230966842064897')
      end
    end

    describe 'GET /v2/bot/followers/ids' do
      it 'returns a list of followers with optional parameters' do
        response_body = { "userIds" => ["U1234567890", "U0987654321"], "next" => "nextToken" }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/followers/ids")
          .with(
            headers: { 'Authorization' => "Bearer #{channel_access_token}" },
            query: { "start" => "prevToken", "limit" => "10" }
          )
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body, status_code, = client.get_followers_with_http_info(start: "prevToken", limit: 10)

        expect(status_code).to eq(200)
        expect(body.user_ids).to eq(["U1234567890", "U0987654321"])
        expect(body._next).to eq("nextToken")
      end
    end

    describe 'GET /v2/bot/profile/{userId}' do
      it 'gets a user profile' do
        user_id = 'U1234567890'
        response_body = {
          "displayName" => "LINE taro",
          "userId" => user_id,
          "language" => "en",
          "pictureUrl" => "https://profile.line-scdn.net/example",
          "statusMessage" => "Hello!"
        }.to_json

        stub_request(:get, "https://api.line.me/v2/bot/profile/#{user_id}")
          .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
          .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

        body = client.get_profile(user_id: user_id)

        expect(body).to be_a(Line::Bot::V2::MessagingApi::UserProfileResponse)
        expect(body.display_name).to eq('LINE taro')
        expect(body.user_id).to eq(user_id)
      end
    end
  end

  describe 'MessagingApi Blob delegation (data API)' do
    describe 'GET /v2/bot/message/{messageId}/content' do
      it 'downloads message content via unified client using data API base URL' do
        message_id = 'test-message-id'

        stub_request(:get, "https://api-data.line.me/v2/bot/message/#{message_id}/content/transcoding")
          .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
          .to_return(status: 200, body: { "status" => "processing" }.to_json, headers: { 'Content-Type' => 'application/json' })

        body, status_code, = client.get_message_content_transcoding_by_message_id_with_http_info(message_id: message_id)

        expect(status_code).to eq(200)
        expect(body.status).to eq('processing')
      end
    end
  end

  describe 'Liff API delegation' do
    describe 'PUT /liff/v1/apps/{liffId}' do
      it 'updates a LIFF app via unified client' do
        stub_request(:put, "https://api.line.me/liff/v1/apps/test-liff-id")
          .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
          .to_return(status: 200, body: "", headers: {})

        request = Line::Bot::V2::Liff::UpdateLiffAppRequest.new(view: { url: 'https://example.com' })
        body, status_code, = client.update_liff_app_with_http_info(liff_id: 'test-liff-id', update_liff_app_request: request)

        expect(status_code).to eq(200)
        expect(body).to eq("")
      end
    end
  end

  describe 'ManageAudience API delegation' do
    describe 'POST /v2/bot/audienceGroup/upload' do
      it 'creates an audience group via unified client' do
        response_body = { "description" => "Test Audience response" }.to_json

        stub_request(:post, "https://api.line.me/v2/bot/audienceGroup/upload")
          .with(
            body: "{\"description\":\"Test Audience\"}",
            headers: {
              'Authorization' => "Bearer #{channel_access_token}",
              'Content-Type' => 'application/json'
            }
          )
          .to_return(status: 202, body: response_body, headers: { 'Content-Type' => 'application/json' })

        request = Line::Bot::V2::ManageAudience::CreateAudienceGroupRequest.new(description: 'Test Audience')
        body, status_code, = client.create_audience_group_with_http_info(create_audience_group_request: request)

        expect(status_code).to eq(202)
        expect(body.description).to eq('Test Audience response')
      end
    end
  end

  describe 'custom base URLs' do
    let(:client) do
      Line::Bot::V2::LineBotClient.new(
        channel_access_token: channel_access_token,
        api_base_url: 'https://custom-api.example.com',
        data_api_base_url: 'https://custom-data.example.com'
      )
    end

    it 'uses custom api_base_url for normal API endpoints' do
      user_id = 'U1234567890'
      response_body = { "displayName" => "Taro", "userId" => user_id }.to_json

      stub_request(:get, "https://custom-api.example.com/v2/bot/profile/#{user_id}")
        .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
        .to_return(status: 200, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body = client.get_profile(user_id: user_id)

      expect(body.display_name).to eq('Taro')
    end

    it 'uses custom data_api_base_url for blob endpoints' do
      message_id = 'test-msg-id'

      stub_request(:get, "https://custom-data.example.com/v2/bot/message/#{message_id}/content/transcoding")
        .with(headers: { 'Authorization' => "Bearer #{channel_access_token}" })
        .to_return(status: 200, body: { "status" => "succeeded" }.to_json, headers: { 'Content-Type' => 'application/json' })

      body = client.get_message_content_transcoding_by_message_id(message_id: message_id)

      expect(body.status).to eq('succeeded')
    end
  end

  describe 'method coverage' do
    # Dynamically discover all API client classes, excluding the same packages as the generator
    excluded_modules = [Line::Bot::V2::ChannelAccessToken, Line::Bot::V2::ModuleAttach].freeze

    original_client_classes = ObjectSpace.each_object(Class).select do |klass|
      klass.name&.match?(/\ALine::Bot::V2::\w+::Api\w*Client\z/) &&
        excluded_modules.none? { |mod| klass.name.start_with?(mod.name) }
    end.sort_by(&:name).freeze

    expected_methods = original_client_classes.flat_map do |klass|
      klass.public_instance_methods(false) - [:initialize]
    end.sort

    unified_methods = Line::Bot::V2::LineBotClient.public_instance_methods(false).sort

    it 'discovers at least one original client class' do
      expect(original_client_classes).not_to be_empty
    end

    it 'exposes every public method from the original API clients' do
      expect(expected_methods.size).to be > 0
      missing = expected_methods - unified_methods
      expect(missing).to be_empty, "Missing methods in unified client: #{missing.join(', ')}"
    end

    it 'does not expose extra methods beyond the original API clients and initialize' do
      extra = unified_methods - expected_methods - [:initialize]
      expect(extra).to be_empty, "Extra methods in unified client: #{extra.join(', ')}"
    end

    it 'has no method name collisions across original clients' do
      all_names = original_client_classes.flat_map { |k| k.public_instance_methods(false) - [:initialize] }
      duplicates = all_names.group_by(&:itself).select { |_, v| v.size > 1 }.keys
      expect(duplicates).to be_empty, "Method name collisions: #{duplicates.join(', ')}"
    end
  end

  describe 'generated file quality' do
    generated_rb = File.read(File.expand_path('../../../../lib/line/bot/v2/line_bot_client.generated.rb', __dir__), encoding: 'utf-8')

    it 'has a YARD comment block before every method' do
      lines = generated_rb.lines
      method_count = 0
      lines.each_with_index do |line, i|
        next unless line =~ /^\s+def\s+(\w+)/

        method_count += 1
        prev = i > 0 ? lines[i - 1].strip : ''
        expect(prev).to start_with('#'),
                        "Method #{Regexp.last_match(1)} (line #{i + 1}) has no preceding YARD comment"
      end
      expect(method_count).to be > 0, "No methods found in generated file"
    end

    it 'has no bare (unqualified) model types in YARD comments' do
      generated_rb.each_line.with_index(1) do |line, lineno|
        next unless line.include?('@param') || line.include?('@return')

        # Match model types like FooResponse/FooRequest that are NOT preceded by "::"
        line.scan(/(?<!::)\b([A-Z][A-Za-z0-9]*(?:Response|Request)\w*)\b/).flatten.each do |type_name|
          expect(line).to include("::#{type_name}"),
                          "Line #{lineno}: bare type #{type_name} should be fully qualified"
        end
      end
    end
  end

  describe 'RBS coverage' do
    rbs_path = File.expand_path('../../../../sig/line/bot/v2/line_bot_client.rbs', __dir__)
    rbs_content = File.read(rbs_path, encoding: 'utf-8')

    # Extract method names from the RBS (public only, before "private" keyword)
    rbs_public_methods = []
    in_private = false
    rbs_content.each_line do |line|
      in_private = true if line.strip == 'private'
      next if in_private

      if (line =~ /^\s+def\s+(\w+[?!]?):/) && Regexp.last_match(1) != 'initialize'
        rbs_public_methods << Regexp.last_match(1).to_sym
      end
    end

    original_rbs_methods_by_file = {}
    Dir[File.expand_path('../../../../sig/line/bot/v2/*/api/*_client.rbs', __dir__)].sort.each do |path|
      # e.g. ".../sig/line/bot/v2/insight/api/insight_client.rbs" -> "insight"
      pkg = File.basename(File.dirname(File.dirname(path)))
      next if %w[channel_access_token module_attach].include?(pkg)

      methods = []
      File.readlines(path).each do |line|
        if line =~ /^\s+def\s+(\w+[?!]?):/ && Regexp.last_match(1) != 'initialize'
          methods << Regexp.last_match(1).to_sym
        end
      end
      original_rbs_methods_by_file[File.basename(path)] = methods
    end
    all_original_rbs_methods = original_rbs_methods_by_file.values.flatten.sort

    it 'declares every method from the original RBS files' do
      expect(all_original_rbs_methods.size).to be > 0, "No original RBS methods found"
      expect(rbs_public_methods.size).to be > 0, "No unified RBS methods found"
      missing = all_original_rbs_methods - rbs_public_methods
      expect(missing).to be_empty, "Missing in unified RBS: #{missing.join(', ')}"
    end

    it 'does not declare extra public methods beyond the originals' do
      extra = rbs_public_methods - all_original_rbs_methods
      expect(extra).to be_empty, "Extra in unified RBS: #{extra.join(', ')}"
    end

    it 'has no bare (unqualified) model types in signatures' do
      # Types like "GetFriendsDemographicsResponse" should appear as "Line::Bot::V2::Insight::GetFriendsDemographicsResponse"
      rbs_content.each_line.with_index(1) do |line, lineno|
        next if line.strip.start_with?('#')  # skip comments
        next unless line.include?('Response') || line.include?('Request')

        line.scan(/(?<!::)\b([A-Z][A-Za-z0-9]*(?:Response|Request)\w*)\b/).flatten.each do |type_name|
          # Must be preceded by "::" (i.e. qualified) in the original line
          expect(line).to include("::#{type_name}"),
                          "Line #{lineno}: bare type #{type_name} should be fully qualified"
        end
      end
    end
  end
end
