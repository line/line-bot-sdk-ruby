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
      # Please use {Line::Bot::V2::Webhook::Event} instead.

      class Base
        def initialize(src)
          warn '[DEPRECATION] Webhook models in V1 is deprecated. Please use V2 instead.' unless ENV['SUPRESS_V1_DEPRECATION_WARNINGS']

          @src = src
        end

        def [](key)
          @src[key]
        end

        def to_hash
          @src
        end
      end
    end
  end
end
