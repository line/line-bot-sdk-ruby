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
        # Audience group job
        # @see https://developers.line.biz/en/reference/messaging-api/#get-audience-group
        class AudienceGroupJob
          # @!attribute [rw] audience_group_job_id
          #   @return [Integer,nil] A job ID.
          attr_accessor :audience_group_job_id
          # @!attribute [rw] audience_group_id
          #   @return [Integer,nil] An audience ID.
          attr_accessor :audience_group_id
          # @!attribute [rw] description
          #   @return [String,nil] The job's description.
          attr_accessor :description
          # @!attribute [rw] type
          #   @return [String,nil] ('DIFF_ADD') 
          attr_accessor :type
          # @!attribute [rw] job_status
          #   @return [String,nil] ('QUEUED'|'WORKING'|'FINISHED'|'FAILED') 
          attr_accessor :job_status
          # @!attribute [rw] failed_type
          #   @return [String,nil] ('INTERNAL_ERROR'|'AUDIENCE_GROUP_AUDIENCE_INSUFFICIENT') 
          attr_accessor :failed_type
          # @!attribute [rw] audience_count
          #   @return [Integer,nil] The number of accounts (recipients) that were added or removed.
          attr_accessor :audience_count
          # @!attribute [rw] created
          #   @return [Integer,nil] When the job was created (in UNIX time).
          attr_accessor :created

          # @param audience_group_job_id [Integer,nil] A job ID.
          # @param audience_group_id [Integer,nil] An audience ID.
          # @param description [String,nil] The job's description.
          # @param type [String,nil] ('DIFF_ADD') 
          # @param job_status [String,nil] ('QUEUED'|'WORKING'|'FINISHED'|'FAILED') 
          # @param failed_type [String,nil] ('INTERNAL_ERROR'|'AUDIENCE_GROUP_AUDIENCE_INSUFFICIENT') 
          # @param audience_count [Integer,nil] The number of accounts (recipients) that were added or removed.
          # @param created [Integer,nil] When the job was created (in UNIX time).
          def initialize(
            audience_group_job_id: nil,
            audience_group_id: nil,
            description: nil,
            type: nil,
            job_status: nil,
            failed_type: nil,
            audience_count: nil,
            created: nil,
            **dynamic_attributes
          )
            
            @audience_group_job_id = audience_group_job_id
            @audience_group_id = audience_group_id
            @description = description
            @type = type
            @job_status = job_status
            @failed_type = failed_type
            @audience_count = audience_count
            @created = created

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
