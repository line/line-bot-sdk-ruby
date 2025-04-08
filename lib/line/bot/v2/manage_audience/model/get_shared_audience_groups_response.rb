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
      module ManageAudience
        # Gets data for more than one audience.
        # @see https://developers.line.biz/en/reference/messaging-api/#get-audience-groups
        class GetSharedAudienceGroupsResponse
          # @!attribute [rw] audience_groups
          #   @return [Array[AudienceGroup],nil] An array of audience data. If there are no audiences that match the specified filter, an empty array will be returned.
          attr_accessor :audience_groups
          # @!attribute [rw] has_next_page
          #   @return [Boolean,nil] true when this is not the last page.
          attr_accessor :has_next_page
          # @!attribute [rw] total_count
          #   @return [Integer,nil] The total number of audiences that can be returned with the specified filter.
          attr_accessor :total_count
          # @!attribute [rw] read_write_audience_group_total_count
          #   @return [Integer,nil] Of the audiences you can get with the specified filter, the number of audiences with the update permission set to READ_WRITE.
          attr_accessor :read_write_audience_group_total_count
          # @!attribute [rw] page
          #   @return [Integer,nil] The current page number.
          attr_accessor :page
          # @!attribute [rw] size
          #   @return [Integer,nil] The maximum number of audiences on the current page.
          attr_accessor :size

          # @param audience_groups [Array[AudienceGroup],nil] An array of audience data. If there are no audiences that match the specified filter, an empty array will be returned.
          # @param has_next_page [Boolean,nil] true when this is not the last page.
          # @param total_count [Integer,nil] The total number of audiences that can be returned with the specified filter.
          # @param read_write_audience_group_total_count [Integer,nil] Of the audiences you can get with the specified filter, the number of audiences with the update permission set to READ_WRITE.
          # @param page [Integer,nil] The current page number.
          # @param size [Integer,nil] The maximum number of audiences on the current page.
          def initialize(
            audience_groups: nil,
            has_next_page: nil,
            total_count: nil,
            read_write_audience_group_total_count: nil,
            page: nil,
            size: nil,
            **dynamic_attributes
          )
            
            @audience_groups = audience_groups&.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::ManageAudience::AudienceGroup.create(**item) # steep:ignore InsufficientKeywordArguments
              else
                item
              end
            end
            @has_next_page = has_next_page
            @total_count = total_count
            @read_write_audience_group_total_count = read_write_audience_group_total_count
            @page = page
            @size = size

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

          def self.create(args) # steep:ignore
            return new(**args) # steep:ignore
          end
        end
      end
    end
  end
end
