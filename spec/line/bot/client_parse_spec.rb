require 'spec_helper'

EVENTS_CONTENT = <<"EOS"
{
  "events": [
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "text",
        "text": "message"
      }
    },
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "group",
        "groupId": "groupid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "image"
      }
    },
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "room",
        "roomId": "roomid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "video"
      }
    },
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "room",
        "roomId": "roomid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "audio"
      }
    },
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "location",
        "title": "label",
        "address": "tokyo",
        "latitude": -34.12,
        "longitude": 134.23
      }
    },
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "sticker",
        "packageId": "1",
        "stickerId": "2"
      }
    },
    {
      "type": "follow",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken"
    },
    {
      "type": "unfollow",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      }
    },
    {
      "type": "join",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken"
    },
    {
      "type": "leave",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      }
    },
    {
      "type": "postback",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "postback.data": "postback"
    },
    {
      "type": "beacon",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "beacon": {
        "hwid": "hwid",
        "type": "enter"
      }
    }
  ]
}
EOS

UNKNOWN_EVENT_CONTENT = <<"EOS"
{
  "events": [
    {
      "type": "unknown",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid",
        "type": "new_type"
      }
    }
  ]
}
EOS

UNSUPPORT_MESSAGE_EVENT_CONTENT = <<"EOS"
{
  "events": [
    {
      "type": "message",
      "timestamp": 12345678901234,
      "source": {
        "type": "user",
        "userId": "userid"
      },
      "replyToken": "replytoken",
      "message": {
        "id": "contentid"
      }
    }
  ]
}
EOS

describe Line::Bot::Client do

  before do
  end

  def dummy_config
    {
      channel_token: 'access token',
    }
  end

  def generate_client
    client = Line::Bot::Client.new do |config|
      config.channel_token = dummy_config[:channel_token]
    end

    client
  end

  it 'parses events' do
    client = generate_client
    events = client.parse_events_from(EVENTS_CONTENT)

    message = {"id" => "contentid", "type" => "text", "text" => "message"}
    expect(events[0]).to be_a(Line::Bot::Event::Message)
    expect(events[0].type).to eq(Line::Bot::Event::MessageType::Text)
    expect(events[0].message).to eq message

    message = {"id"=>"contentid", "type"=>"image"}
    expect(events[1]).to be_a(Line::Bot::Event::Message)
    expect(events[1].type).to eq(Line::Bot::Event::MessageType::Image)
    expect(events[1].message).to eq message

    message = {"id"=>"contentid", "type"=>"video"}
    expect(events[2]).to be_a(Line::Bot::Event::Message)
    expect(events[2].type).to eq(Line::Bot::Event::MessageType::Video)
    expect(events[2].message).to eq message

    message = {"id"=>"contentid", "type"=>"audio"}
    expect(events[3]).to be_a(Line::Bot::Event::Message)
    expect(events[3].type).to eq(Line::Bot::Event::MessageType::Audio)
    expect(events[3].message).to eq message

    message = {"id"=>"contentid", "type"=>"location", "title"=>"label", "address"=>"tokyo", "latitude"=>-34.12, "longitude"=>134.23}
    expect(events[4]).to be_a(Line::Bot::Event::Message)
    expect(events[4].type).to eq(Line::Bot::Event::MessageType::Location)
    expect(events[4].message).to eq message

    message = {"id"=>"contentid", "type"=>"sticker", "packageId"=>"1", "stickerId"=>"2"}
    expect(events[5]).to be_a(Line::Bot::Event::Message)
    expect(events[5].type).to eq(Line::Bot::Event::MessageType::Sticker)
    expect(events[5].message).to eq message

    expect(events[6]).to be_a(Line::Bot::Event::Follow)
    expect(events[7]).to be_a(Line::Bot::Event::Unfollow)
    expect(events[8]).to be_a(Line::Bot::Event::Join)
    expect(events[9]).to be_a(Line::Bot::Event::Leave)
    expect(events[10]).to be_a(Line::Bot::Event::Postback)
    expect(events[11]).to be_a(Line::Bot::Event::Beacon)
  end

  it 'parses unknown event' do
    client = generate_client
    events = client.parse_events_from(UNKNOWN_EVENT_CONTENT)

    expect(events[0]).to be_a(Line::Bot::Event::Base)
  end

  it 'parses unsupport message event' do
    client = generate_client
    events = client.parse_events_from(UNSUPPORT_MESSAGE_EVENT_CONTENT)

    expect(events[0]).to be_a(Line::Bot::Event::Message)
    expect(events[0].type).to eq(Line::Bot::Event::MessageType::Unsupport)
  end

end
