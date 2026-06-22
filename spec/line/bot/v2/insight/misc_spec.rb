require 'spec_helper'

describe 'Insight' do
  let(:channel_access_token) { 'YOUR_CHANNEL_ACCESS_TOKEN' }

  describe 'GET /v2/bot/insight/message/event/aggregation' do
    let(:client) { Line::Bot::V2::Insight::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_code) { 200 }

    it 'returns the message event aggregation successfully' do
      response_body = {
        "overview": {
          "uniqueImpression": 40,
          "uniqueClick": 30,
          "uniqueMediaPlayed": 25,
          "uniqueMediaPlayed100Percent": nil
        },
        "messages": [
          {
            "seq": 1,
            "impression": 42,
            "uniqueImpression": 40,
            "mediaPlayed": 30,
            "mediaPlayed25Percent": nil,
            "mediaPlayed50Percent": nil,
            "mediaPlayed75Percent": nil,
            "mediaPlayed100Percent": nil,
            "uniqueMediaPlayed": 25,
            "uniqueMediaPlayed25Percent": nil,
            "uniqueMediaPlayed50Percent": nil,
            "uniqueMediaPlayed75Percent": nil,
            "uniqueMediaPlayed100Percent": nil
          }
        ],
        "clicks": [
          {
            "seq": 1,
            "url": "https://developers.line.biz/",
            "click": 35,
            "uniqueClick": 25,
            "uniqueClickOfRequest": nil
          },
          {
            "seq": 1,
            "url": "https://lineapiusecase.com/",
            "click": 29,
            "uniqueClick": nil,
            "uniqueClickOfRequest": nil
          }
        ]
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/message/event/aggregation")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          },
          query: {
            "customAggregationUnit" => "a_bc_de",
            "from" => "20210301",
            "to" => "20210331"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body = client.get_statistics_per_unit(
        custom_aggregation_unit: 'a_bc_de',
        from: '20210301',
        to: '20210331'
      )

      expect(body.overview.unique_impression).to eq(40)
      expect(body.overview.unique_click).to eq(30)
      expect(body.overview.unique_media_played100_percent).to be_nil

      expect(body.messages[0].seq).to eq(1)
      expect(body.messages[0].impression).to eq(42)
      expect(body.messages[0].unique_media_played25_percent).to be_nil

      expect(body.clicks[0].seq).to eq(1)
      expect(body.clicks[0].url).to eq('https://developers.line.biz/')
      expect(body.clicks[0].unique_click_of_request).to be_nil
    end
  end

  describe 'GET /v2/bot/insight/followers' do
    let(:client) { Line::Bot::V2::Insight::ApiClient.new(channel_access_token: channel_access_token) }
    let(:response_code) { 200 }

    it 'returns the number of followers successfully (ready status)' do
      response_body = {
        "status" => "ready",
        "followers" => 1000,
        "targetedReaches" => 900,
        "blocks" => 100
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, = client.get_number_of_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.status).to eq('ready')
      expect(body.followers).to eq(1000)
      expect(body.targeted_reaches).to eq(900)
      expect(body.blocks).to eq(100)
    end

    it 'handles the null fields properly (unready status)' do
      response_body = {
        "status" => "unready",
        "followers" => nil,
        "targetedReaches" => nil,
        "blocks" => nil
      }.to_json

      stub_request(:get, "https://api.line.me/v2/bot/insight/followers")
        .with(
          headers: {
            'Authorization' => "Bearer #{channel_access_token}"
          }
        )
        .to_return(status: response_code, body: response_body, headers: { 'Content-Type' => 'application/json' })

      body, status_code, = client.get_number_of_followers_with_http_info

      expect(status_code).to eq(200)
      expect(body.status).to eq('unready')
      expect(body.followers).to be_nil
      expect(body.targeted_reaches).to be_nil
      expect(body.blocks).to be_nil
    end
  end

  describe 'Line::Bot::V2::Insight::AgeTile#initialize' do
    it 'creates AgeTile correctly' do
      age_tile = Line::Bot::V2::Insight::AgeTile.new(
        age: 'from15to19',
        percentage: 50.0
      )

      expect(age_tile.age).to eq('from15to19')
      expect(age_tile.percentage).to eq(50.0)
    end

    context 'with invalid enum value' do
      it "doesn't raise any error" do
        age_tile = Line::Bot::V2::Insight::AgeTile.new(
          age: 'unknown', # invalid value
          percentage: 50.0
        )

        expect(age_tile.age).to eq('unknown')
        expect(age_tile.percentage).to eq(50.0)
      end
    end
  end
end
