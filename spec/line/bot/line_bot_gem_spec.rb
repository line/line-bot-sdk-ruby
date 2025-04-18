# spec/line_bot_load_spec.rb
# This file uses the shared examples to test both "line-bot-api" and "line/bot".

require 'rspec'
require_relative '../../shared/no_missing_require_spec'

ROOT_DIR = File.expand_path('../../../', __dir__)
LIB_DIR  = File.join(ROOT_DIR, 'lib')

PATH_LINE_BOT_RB  = File.join(LIB_DIR, 'line/bot.rb')

RSpec.describe "Check require statements for multiple entrypoints" do
  context "testing line/bot entrypoint" do
    include_examples "library entrypoint loader",
                     "line/bot",
                     PATH_LINE_BOT_RB,
                     LIB_DIR
  end
end
