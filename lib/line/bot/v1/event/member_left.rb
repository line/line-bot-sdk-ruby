# Copyright 2016 LINE
#
# LINE Corporation licenses this file to you under the Apache License,
# version 2.0 (the "License"); you may not use this file except in compliance
# with the License. You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

module Line
  module Bot
    module Event
      # @deprecated
      # This is deprecated.
      # Please use {Line::Bot::V2::Webhook::LeftMembers} instead.
      #
      # Event object for when a user leaves a group or room that the LINE official account is in.
      #
      # No replyToken is generated for this event.
      #
      # https://developers.line.biz/en/reference/messaging-api/#member-left-event
      class MemberLeft < Base
      end
    end
  end
end
