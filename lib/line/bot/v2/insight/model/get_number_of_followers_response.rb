# LINE Messaging API(Insight)
# This document describes LINE Messaging API(Insight).
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module Insight
        # Get number of followers
        # @see https://developers.line.biz/en/reference/messaging-api/#get-number-of-followers
        class GetNumberOfFollowersResponse
          attr_accessor :status # Calculation status.
          attr_accessor :followers # The number of times, as of the specified date, that a user added this LINE Official Account as a friend for the first time. The number doesn't decrease even if a user later blocks the account or when they delete their LINE account. 
          attr_accessor :targeted_reaches # The number of users, as of the specified date, that the LINE Official Account can reach through targeted messages based on gender, age, and/or region. This number only includes users who are active on LINE or LINE services and whose demographics have a high level of certainty. 
          attr_accessor :blocks # The number of users blocking the account as of the specified date. The number decreases when a user unblocks the account.   

          def initialize(
            status: nil,
            followers: nil,
            targeted_reaches: nil,
            blocks: nil,
            **dynamic_attributes
          )
            
            @status = status
            @followers = followers
            @targeted_reaches = targeted_reaches
            @blocks = blocks

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key

              if value.is_a?(Hash)
                struct_klass = Struct.new(*value.keys.map(&:to_sym))
                struct_values = value.map { |_k, v| v.is_a?(Hash) ? Line::Bot::V2::Utils.hash_to_struct(v) : v }
                instance_variable_set("@#{key}", struct_klass.new(*struct_values))
              else
                instance_variable_set("@#{key}", value)
              end
            end
          end

          def self.create(args)
            return new(**args)
          end
        end
      end
    end
  end
end
