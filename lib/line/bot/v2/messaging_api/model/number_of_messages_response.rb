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
        class NumberOfMessagesResponse
          attr_accessor :status # Aggregation process status. One of:  `ready`: The number of messages can be obtained. `unready`: We haven't finished calculating the number of sent messages for the specified in date. For example, this property is returned when the delivery date or a future date is specified. Calculation usually takes about a day. `unavailable_for_privacy`: The total number of messages on the specified day is less than 20. `out_of_service`: The specified date is earlier than the date on which we first started calculating sent messages (March 31, 2018). 
          attr_accessor :success # The number of messages delivered using the phone number on the date specified in `date`. The response has this property only when the value of `status` is `ready`.  

          def initialize(
            status:,
            success: nil
          )
            
            @status = status
            @success = success
          end
        end
      end
    end
  end
end
