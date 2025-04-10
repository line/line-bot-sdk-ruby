# Make sure this file runs with minimal or no prior requires to confirm the library is not already loaded.
# Thus do not require spec_helper here.

require 'rspec'
# This file defines shared examples for checking require statements.

RSpec.shared_examples "library entrypoint loader" do |require_name, main_file_path, lib_dir|
  it "confirms that '#{main_file_path}' is not already loaded" do
    unless File.file?(main_file_path)
      fail "File not found: #{main_file_path}"
    end

    loaded_files_before = $LOADED_FEATURES.map { |f| File.expand_path(f) rescue f }
    expect(loaded_files_before).not_to include(main_file_path), <<~MSG
      '#{main_file_path}' appears to be loaded before this test runs! Loaded files:
      #{loaded_files_before.join("\n")}
    MSG
  end

  it "requires '#{require_name}' and checks that all files under '#{lib_dir}' are loaded" do
    require require_name

    # Gather all .rb files under lib_dir
    all_lib_files = Dir[File.join(lib_dir, '**/*.rb')]
    if all_lib_files.empty?
      fail "No .rb files found under #{lib_dir}. Check your path."
    end

    loaded_files_after = $LOADED_FEATURES.map { |f| File.expand_path(f) rescue f }

    unrequired = all_lib_files - loaded_files_after - [File.join(lib_dir, 'line-bot-api.rb')]
    expect(unrequired).to be_empty, <<~MSG
      These files under #{lib_dir} were NOT loaded by 'require "#{require_name}"':
      #{unrequired.join("\n")}
    MSG
  end
end
