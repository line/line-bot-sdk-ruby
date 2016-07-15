# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'line/bot/api/version'

Gem::Specification.new do |spec|
  spec.name          = "line-bot-api"
  spec.version       = Line::Bot::API::VERSION
  spec.authors       = ["LINE Corporation"]
  spec.email         = ["hirohisa.kawasaki@gmail.com"]

  spec.description   = "Line::Bot::API - SDK of the LINE BOT API"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/line/line-bot-sdk-ruby"
  spec.license       = "Apache-2.0"

  spec.files         = %w(CONTRIBUTING.md LICENSE README.md line-bot-api.gemspec) + Dir['lib/**/*.rb']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version     = '>= 2.0.0'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "webmock", "~> 1.24"
  spec.add_development_dependency "rest-client", "~> 1.8"
  spec.add_development_dependency "httpclient", "~> 2.8"
  spec.add_development_dependency "addressable", "~> 2.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
