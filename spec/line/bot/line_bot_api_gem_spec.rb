# spec/line_bot_load_spec.rb
# This file uses the shared examples to test both "line-bot-api" and "line/bot".

require 'rspec'
require_relative '../../shared/no_missing_require_spec'

RSpec.describe "Check require statements for multiple entrypoints" do
  ROOT_DIR = File.expand_path('../../../', __dir__)
  LIB_DIR  = File.join(ROOT_DIR, 'lib')

  PATH_LINE_BOT_API = File.join(LIB_DIR, 'line-bot-api.rb')

  context "testing line-bot-api entrypoint" do
    include_examples "library entrypoint loader",
                     "line-bot-api",
                     PATH_LINE_BOT_API,
                     LIB_DIR
  end
end
