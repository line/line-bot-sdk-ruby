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
        class Membership
          attr_accessor :membership_id # Membership plan ID.
          attr_accessor :title # Membership plan name.
          attr_accessor :description # Membership plan description.
          attr_accessor :benefits # List of membership plan perks.
          attr_accessor :price # Monthly fee for membership plan. (e.g. 1500.00)
          attr_accessor :currency # The currency of membership.price.
          attr_accessor :member_count # Number of members subscribed to the membership plan.
          attr_accessor :member_limit # The upper limit of members who can subscribe. If no upper limit is set, it will be null.
          attr_accessor :is_in_app_purchase # Payment method for users who subscribe to a membership plan.
          attr_accessor :is_published # Membership plan status.

          def initialize(
            membership_id:,
            title:,
            description:,
            benefits:,
            price:,
            currency:,
            member_count:,
            member_limit:,
            is_in_app_purchase:,
            is_published:,
            **dynamic_attributes
          )
            
            @membership_id = membership_id
            @title = title
            @description = description
            @benefits = benefits.map do |item|
              if item.is_a?(Hash)
                Line::Bot::V2::MessagingApi::string.create(**item)
              else
                item
              end
            end
            @price = price
            @currency = currency
            @member_count = member_count
            @member_limit = member_limit
            @is_in_app_purchase = is_in_app_purchase
            @is_published = is_published

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
