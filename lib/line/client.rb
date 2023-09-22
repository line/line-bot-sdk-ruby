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

require 'line/client/version'
require 'line/client/webhook'

clients_dir = File.expand_path('../clients', __dir__)

clients = [
  'channel-access-token',
  'insight',
  'liff',
  'manage-audience',
  'messaging-api',
  'module-attach',
  'module',
  'shop',
  'webhook'
]

clients.each do |client|
  lib_dir = "#{clients_dir}/#{client}/lib"
  $LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
end

require 'line_client_channel_access_token'
require 'line_client_insight'
require 'line_client_liff'
require 'line_client_manage_audience'
require 'line_client_messaging_api'
require 'line_client_module_attach'
require 'line_client_module'
require 'line_client_shop'
require 'line_client_webhook'
