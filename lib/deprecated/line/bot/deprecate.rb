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
    module Deprecate
      def deprecate(name, replacement = nil)
        class_eval do
          deprecated_name = "_deprecated_#{name}"
          alias_method deprecated_name, name
          define_method name do |*args, &block|
            message = "NOTE: #{self.class}##{name} is deprecated"
            message += "; use #{replacement} instead" if replacement
            message += "."
            warn message
            send deprecated_name, *args, &block
          end
          ruby2_keywords name if respond_to?(:ruby2_keywords, true)
        end
      end
    end
  end
end
