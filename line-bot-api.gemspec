version = File.read("#{__dir__}/lib/line/bot/version.rb").match(/VERSION *= *['"]([^'"]+)/)[1] or raise
raise "Invalid version format <#{version}>" unless version.match?(/\A\d+\.\d+\.\d+(?:[+-][\w.-]+)?\z/)

Gem::Specification.new do |spec|
  spec.name          = "line-bot-api"
  spec.version       = version
  spec.authors       = ["LINE Corporation"]
  spec.email         = ["kimoto@linecorp.com", "todaka.yusuke@linecorp.com", "masaki_kurosawa@linecorp.com"]

  spec.description   = "Line::Bot::API - SDK of the LINE Messaging API for Ruby"
  spec.summary       = "SDK of the LINE Messaging API"
  spec.homepage      = "https://github.com/line/line-bot-sdk-ruby"
  spec.license       = "Apache-2.0"

  spec.files         = %w(CONTRIBUTING.md LICENSE README.md line-bot-api.gemspec) + Dir['lib/**/*.rb'] + Dir['sig/**/*.rbs']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 3.2.0'

  spec.add_dependency "multipart-post", "~> 2.4.1"

  spec.add_development_dependency "addressable", "~> 2.3"
  spec.add_development_dependency 'rake', "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.8"
end
