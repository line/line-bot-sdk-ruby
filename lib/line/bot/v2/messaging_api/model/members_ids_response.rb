# LINE Messaging API
# This document describes LINE Messaging API.
#
# The version of the OpenAPI document: 0.0.1
#
# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

module Line
  module Bot
    module V2
      module MessagingApi
        class MembersIdsResponse
          attr_accessor :member_ids # List of user IDs of members in the group chat. Only users of LINE for iOS and LINE for Android are included in `memberIds`.
          attr_accessor :_next # A continuation token to get the next array of user IDs of the members in the group chat. Returned only when there are remaining user IDs that were not returned in `memberIds` in the original request. 

          # @param member_ids [Array[String]] List of user IDs of members in the group chat. Only users of LINE for iOS and LINE for Android are included in `memberIds`.
          # @param _next [String] A continuation token to get the next array of user IDs of the members in the group chat. Returned only when there are remaining user IDs that were not returned in `memberIds` in the original request. 
          def initialize(
            member_ids:,
            _next: nil,
            **dynamic_attributes
          )
            
            @member_ids = member_ids.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::string.create(**item)
              else
                item
              end
            end
            @_next = _next

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
