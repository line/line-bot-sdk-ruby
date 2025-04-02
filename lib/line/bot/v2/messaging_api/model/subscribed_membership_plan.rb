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
        # Object containing information about the membership plan.
        class SubscribedMembershipPlan
          attr_accessor :membership_id # Membership plan ID.
          attr_accessor :title # Membership plan name.
          attr_accessor :description # Membership plan description.
          attr_accessor :benefits # List of membership plan perks.
          attr_accessor :price # Monthly fee for membership plan. (e.g. 1500.00)
          attr_accessor :currency # The currency of membership.price.

          def initialize(
            membership_id:,
            title:,
            description:,
            benefits:,
            price:,
            currency:,
            **dynamic_attributes
          )
            
            @membership_id = membership_id
            @title = title
            @description = description
            @benefits = benefits
            @price = price
            @currency = currency

            dynamic_attributes.each do |key, value|
              self.class.attr_accessor key
              instance_variable_set("@#{key}", value)
            end
          end
        end
      end
    end
  end
end
