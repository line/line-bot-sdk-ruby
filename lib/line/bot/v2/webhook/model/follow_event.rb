# Webhook Type Definition
# Webhook event definition of the LINE Messaging API
#
# The version of the OpenAPI document: 1.0.0
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

require_relative './event'

# Event object for when your LINE Official Account is added as a friend (or unblocked). You can reply to follow events.
module Line
  module Bot
    module V2
      module Webhook
        class FollowEvent < Event
          attr_accessor :type # Type of the event
          attr_accessor :source
          attr_accessor :timestamp # Time of the event in milliseconds.
          attr_accessor :mode
          attr_accessor :webhook_event_id # Webhook Event ID. An ID that uniquely identifies a webhook event. This is a string in ULID format.
          attr_accessor :delivery_context
          attr_accessor :reply_token # Reply token used to send reply message to this event
          attr_accessor :follow

          def initialize(
            type:,
            source: nil,
            timestamp:,
            mode:,
            webhook_event_id:,
            delivery_context:,
            reply_token:,
            follow:
          )
            @type = type
            @source = source
            @timestamp = timestamp
            @mode = mode
            @webhook_event_id = webhook_event_id
            @delivery_context = delivery_context
            @reply_token = reply_token
            @follow = follow
          end
        end
      end
    end
  end
end