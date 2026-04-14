# frozen_string_literal: true

require 'fileutils'
require 'pathname'
require 'rbs'
require 'set'

# Generates Line::Bot::V2::LineBotClient, a single unified client that wraps all
# individual API clients (MessagingApi, Insight, Liff, ManageAudience, etc.).
#
# Without this, users must instantiate and manage multiple client objects
# themselves, choosing the right one for each API call. The unified client
# eliminates that burden: one object, one channel_access_token, every API.
module UnifiedClientGenerator
  OUTPUT_RB_GENERATED = 'lib/line/bot/v2/line_bot_client.generated.rb'
  OUTPUT_RB_FACTORY = 'lib/line/bot/v2/line_bot_client.factory.generated.rb'
  OUTPUT_RBS = 'sig/line/bot/v2/line_bot_client.rbs'
  BOT_ENTRYPOINT = 'lib/line/bot.rb'
  EXCLUDED_PACKAGES = Set['channel_access_token', 'module_attach'].freeze
  BUILTINS = Set['Array', 'File', 'Float', 'Hash', 'Integer', 'Object', 'String', 'Symbol'].freeze

  CLIENT_CLASS_COMMENT = <<~COMMENT
    A single client for all LINE Bot APIs, except channel access token and module attach management.

    It wraps the individual generated API clients and exposes their methods directly,
    so callers can work with one object instead of juggling several client instances.

    For channel access token operations, use {Line::Bot::V2::ChannelAccessToken::ApiClient} directly.
    For module attach operations, use {Line::Bot::V2::ModuleAttach::ApiClient} directly.
  COMMENT

  CLIENT_INITIALIZE_COMMENT = <<~COMMENT
    @param channel_access_token [String] Channel access token issued for your LINE Official Account.
    @param api_base_url [String, nil] Base URL for Messaging API style endpoints. Defaults to https://api.line.me.
    @param data_api_base_url [String, nil] Base URL for data/blob endpoints. Defaults to https://api-data.line.me.
    @param http_options [Hash{String|Symbol => untyped}] Net::HTTP options passed to all generated clients.
  COMMENT

  ClientSpec = Struct.new(:package_dir, :namespace_name, :class_name, :delegate_name,
                          :default_base_url, :constructor_required_keywords,
                          :constructor_optional_keywords, :delegated_methods, :model_names,
                          keyword_init: true) do
    def namespace_reference
      "Line::Bot::V2::#{namespace_name}"
    end

    def qualified_class_name
      "Line::Bot::V2::#{namespace_name}::#{class_name}"
    end

    def ivar_name
      "@#{delegate_name}"
    end
  end

  MethodSpec = Struct.new(:name, :comment, :required_keywords, :optional_keywords, :return_type,
                          keyword_init: true)

  module_function

  def run(root_dir = File.expand_path('../..', __dir__))
    root = Pathname(root_dir)
    ruby_clients = discover_clients_from_ruby(root)
    rbs_clients = discover_clients_from_rbs(root)
    validate_clients!(ruby_clients)
    validate_rb_rbs_consistency!(ruby_clients, rbs_clients)

    write(root.join(OUTPUT_RB_GENERATED), render_generated_ruby(ruby_clients))
    write(root.join(OUTPUT_RB_FACTORY), render_factory_ruby(ruby_clients))
    write(root.join(OUTPUT_RBS), render_rbs(rbs_clients))
    patch_bot_entrypoint!(root.join(BOT_ENTRYPOINT))

    n = ruby_clients.sum { |c| c.delegated_methods.size }
    puts "Generated #{OUTPUT_RB_GENERATED}, #{OUTPUT_RB_FACTORY}, #{OUTPUT_RBS}. " \
         "#{ruby_clients.size} client classes, #{n} delegated methods."
  end

  # --- Validation ---

  SUPPORTED_BASE_URLS = Set['https://api.line.me', 'https://api-data.line.me'].freeze

  def validate_clients!(clients)
    raise 'No client files were found.' if clients.empty?

    check_collisions!('Delegate name', clients.map(&:delegate_name))
    check_collisions!('Method name', clients.flat_map { |c| c.delegated_methods.map(&:name) })

    allowed = Set['base_url', 'channel_access_token', 'http_options']

    clients.each do |c|
      req = Set.new(c.constructor_required_keywords)
      opt = Set.new(c.constructor_optional_keywords)
      all = req | opt

      extra = all - allowed
      raise "Unsupported constructor keys in #{c.qualified_class_name}: #{extra.to_a.join(', ')}" unless extra.empty?

      raise "Missing channel_access_token in #{c.qualified_class_name}" unless all.include?('channel_access_token')

      unless SUPPORTED_BASE_URLS.include?(c.default_base_url)
        raise "Unsupported default_base_url #{c.default_base_url.inspect} in #{c.qualified_class_name}. " \
              "Supported: #{SUPPORTED_BASE_URLS.to_a.join(', ')}"
      end
    end
  end

  def validate_rb_rbs_consistency!(ruby_clients, rbs_clients)
    ruby_by_delegate = ruby_clients.to_h { |c| [c.delegate_name, c] }
    rbs_by_delegate = rbs_clients.to_h { |c| [c.delegate_name, c] }

    missing_in_rbs = ruby_by_delegate.keys - rbs_by_delegate.keys
    missing_in_ruby = rbs_by_delegate.keys - ruby_by_delegate.keys
    unless missing_in_rbs.empty? && missing_in_ruby.empty?
      raise "Client mismatch between rb and rbs. " \
            "missing_in_rbs=#{missing_in_rbs.sort.join(', ')}, " \
            "missing_in_ruby=#{missing_in_ruby.sort.join(', ')}"
    end

    ruby_by_delegate.each do |delegate_name, ruby_client|
      rbs_client = rbs_by_delegate.fetch(delegate_name)
      ruby_methods = ruby_client.delegated_methods.map(&:name).sort
      rbs_methods = rbs_client.delegated_methods.map(&:name).sort
      next if ruby_methods == rbs_methods

      missing_in_rbs_methods = ruby_methods - rbs_methods
      missing_in_ruby_methods = rbs_methods - ruby_methods
      raise "Method mismatch for #{delegate_name}. " \
            "missing_in_rbs=#{missing_in_rbs_methods.join(', ')}, " \
            "missing_in_ruby=#{missing_in_ruby_methods.join(', ')}"
    end
  end

  def check_collisions!(label, names)
    dupes = names.tally.select { |_, v| v > 1 }.keys.sort
    raise "#{label} collisions: #{dupes.join(', ')}" unless dupes.empty?
  end

  # --- Utilities ---

  def patch_bot_entrypoint!(path)
    return unless path.exist?

    content = path.read
    required_line = "require 'line/bot/v2/line_bot_client'"
    return if content.include?(required_line)

    write(path, content.rstrip + "\n#{required_line}\n")
  end

  def write(path, content)
    FileUtils.mkdir_p(path.dirname)
    path.write(content)
  end

  def indent(text, depth)
    prefix = ' ' * depth
    text.lines.map { |line| line.chomp.empty? ? line : "#{prefix}#{line}" }.join
  end
end

require_relative 'parser'
require_relative 'renderer'

UnifiedClientGenerator.run(ARGV.fetch(0, File.expand_path('../..', __dir__))) if $PROGRAM_NAME == __FILE__
