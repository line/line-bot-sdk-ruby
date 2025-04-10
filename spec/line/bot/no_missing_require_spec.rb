# spec/line_bot_load_spec.rb
# This file does NOT require spec_helper, to ensure no pre-loading of "line-bot-api" or "line/bot".

require 'rspec'

RSpec.describe "Check require statements for multiple entrypoints (function-style)" do
  # 1) Define references to the root and lib directories.
  ROOT_DIR = File.expand_path('../..', __dir__)  # Adjust if needed
  LIB_DIR  = File.join(ROOT_DIR, 'lib')

  PATH_LINE_BOT_API = File.join(LIB_DIR, 'line-bot-api.rb')
  PATH_LINE_BOT_RB  = File.join(LIB_DIR, 'line/bot.rb')

  # 2) A local method that defines the tests
  #    This method contains `it` blocks, so each call will produce two tests.
  def define_library_tests(require_name, main_file_path, lib_dir)
    it "confirms that '#{require_name}' (#{main_file_path}) is not already loaded" do
      unless File.file?(main_file_path)
        fail "File not found: #{main_file_path}"
      end

      loaded_before = $LOADED_FEATURES.map { |f| File.expand_path(f) rescue f }
      expect(loaded_before).not_to include(main_file_path), <<~MSG
        '#{main_file_path}' appears to be loaded before this test runs!
      MSG
    end

    it "requires '#{require_name}' and checks that all files in '#{lib_dir}' are loaded" do
      require require_name

      all_lib_files = Dir[File.join(lib_dir, '**/*.rb')]
      fail "No .rb files found under #{lib_dir}" if all_lib_files.empty?

      loaded_after = $LOADED_FEATURES.map { |f| File.expand_path(f) rescue f }
      # Filter to only keep files under lib/
      loaded_after.select! { |path| path.start_with?(lib_dir) }

      unrequired = all_lib_files - loaded_after
      expect(unrequired).to be_empty, <<~MSG
        These files under #{lib_dir} were NOT loaded by require '#{require_name}':
        #{unrequired.join("\n")}
      MSG
    end
  end

  # 3) Call that method for each “entrypoint” we want to test
  context "for line-bot-api entrypoint" do
    define_library_tests("line-bot-api", PATH_LINE_BOT_API, LIB_DIR)
  end

  context "for line/bot entrypoint" do
    define_library_tests("line/bot", PATH_LINE_BOT_RB, LIB_DIR)
  end
end
