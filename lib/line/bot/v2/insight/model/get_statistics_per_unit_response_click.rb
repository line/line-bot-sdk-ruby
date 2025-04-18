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
        # @see https://developers.line.biz/en/reference/messaging-api/#get-statistics-per-unit-response
        class GetStatisticsPerUnitResponseClick
          # @!attribute [rw] seq
          #   @return [Integer] The URL's serial number.
          attr_accessor :seq
          # @!attribute [rw] url
          #   @return [String] URL.
          attr_accessor :url
          # @!attribute [rw] click
          #   @return [Integer,nil] Number of times the URL in the bubble was opened.
          attr_accessor :click
          # @!attribute [rw] unique_click
          #   @return [Integer,nil] Number of users that opened the URL in the bubble.
          attr_accessor :unique_click
          # @!attribute [rw] unique_click_of_request
          #   @return [Integer,nil] Number of users who opened this url through any link in the message. If another message bubble contains the same URL and a user opens both links, it's counted only once. 
          attr_accessor :unique_click_of_request

          # @param seq [Integer] The URL's serial number.
          # @param url [String] URL.
          # @param click [Integer,nil] Number of times the URL in the bubble was opened.
          # @param unique_click [Integer,nil] Number of users that opened the URL in the bubble.
          # @param unique_click_of_request [Integer,nil] Number of users who opened this url through any link in the message. If another message bubble contains the same URL and a user opens both links, it's counted only once. 
          def initialize(
            seq:,
            url:,
            click: nil,
            unique_click: nil,
            unique_click_of_request: nil,
            **dynamic_attributes
          )
            
            @seq = seq
            @url = url
            @click = click
            @unique_click = unique_click
            @unique_click_of_request = unique_click_of_request

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

          # @param other [Object] Object to compare
          # @return [Boolean] true if the objects are equal, false otherwise
          def ==(other)
            return false unless self.class == other.class

            instance_variables.all? do |var|
                instance_variable_get(var) == other.instance_variable_get(var)
            end
          end

          # @return [Integer] Hash code of the object
          def hash
            [self.class, *instance_variables.map { |var| instance_variable_get(var) }].hash
          end
        end
      end
    end
  end
end
