require 'spec_helper'
require 'fileutils'
require 'pathname'
require 'tmpdir'

require_relative '../scripts/unified-client-generator/main'

describe UnifiedClientGenerator do
  describe '.parse_client' do
    it 'uses method comments from rbs, not ruby source comments' do
      Dir.mktmpdir do |tmpdir|
        root = Pathname(tmpdir)
        sig_path = root.join('sig/line/bot/v2/foo/api/foo_client.rbs')
        rb_path = root.join('lib/line/bot/v2/foo/api/foo_client.rb')

        FileUtils.mkdir_p(sig_path.dirname)
        FileUtils.mkdir_p(rb_path.dirname)

        sig_path.write(<<~RBS)
          module Line
            module Bot
              module V2
                module Foo
                  class ApiClient
                    def initialize: (
                      ?base_url: String?,
                      channel_access_token: String,
                      ?http_options: Hash[String | Symbol, untyped]
                    ) -> void

                    # RBS_SOURCE_COMMENT
                    # @param model [SampleModel]
                    # @return [SampleModel]
                    def ping: (model: SampleModel) -> SampleModel
                  end
                end
              end
            end
          end
        RBS

        rb_path.write(<<~'RB')
          module Line
            module Bot
              module V2
                module Foo
                  class ApiClient
                    # RB_SOURCE_COMMENT
                    def initialize(base_url: nil, channel_access_token:, http_options: {})
                      @http_client = HttpClient.new(
                        base_url: base_url || 'https://api.line.me',
                        http_headers: { Authorization: "Bearer \\#{channel_access_token}" },
                        http_options: http_options
                      )
                    end
                  end
                end
              end
            end
          end
        RB

        client = UnifiedClientGenerator.parse_client(sig_path: sig_path, rb_path: rb_path)
        method = client.delegated_methods.find { |m| m.name == 'ping' }

        expect(method).not_to be_nil
        expect(method.comment).to include('RBS_SOURCE_COMMENT')
        expect(method.comment).not_to include('RB_SOURCE_COMMENT')
        expect(method.comment).to include('@param model [Line::Bot::V2::Foo::SampleModel]')
        expect(method.comment).to include('@return [Line::Bot::V2::Foo::SampleModel]')
      end
    end
  end

  describe '.parse_client_from_ruby' do
    it 'uses method comments from ruby source as-is' do
      Dir.mktmpdir do |tmpdir|
        rb_path = Pathname(tmpdir).join('lib/line/bot/v2/foo/api/foo_client.rb')
        FileUtils.mkdir_p(rb_path.dirname)

        rb_path.write(<<~'RB')
          module Line
            module Bot
              module V2
                module Foo
                  class ApiClient
                    def initialize(base_url: nil, channel_access_token:, http_options: {})
                      @http_client = HttpClient.new(
                        base_url: base_url || 'https://api.line.me',
                        http_headers: { Authorization: "Bearer #{channel_access_token}" },
                        http_options: http_options
                      )
                    end

                    # RB_BOOLEAN_COMMENT
                    # @param flag [Boolean, nil]
                    def ping_with_http_info(flag: nil)
                      nil
                    end
                  end
                end
              end
            end
          end
        RB

        client = UnifiedClientGenerator.parse_client_from_ruby(rb_path: rb_path)
        method = client.delegated_methods.find { |m| m.name == 'ping_with_http_info' }

        expect(method).not_to be_nil
        expect(method.comment).to include('RB_BOOLEAN_COMMENT')
        expect(method.comment).to include('@param flag [Boolean, nil]')
      end
    end
  end
end
