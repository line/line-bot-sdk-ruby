lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'line/client/version'

Gem::Specification.new do |spec|
  spec.name          = 'line-bot-api'
  spec.version       = LINE::Client::VERSION
  spec.authors       = ['LINE Corporation']
  spec.email         = ['kimoto@linecorp.com', 'todaka.yusuke@linecorp.com', 'masaki_kurosawa@linecorp.com']

  spec.description   = 'LINE Messaging API SDK for Ruby'
  spec.summary       = 'LINE Messaging API SDK for Ruby'
  spec.homepage      = 'https://github.com/line/line-bot-sdk-ruby'
  spec.license       = 'Apache-2.0'

  spec.files         = %w(CONTRIBUTING.md LICENSE README.md line-bot-api.gemspec) + Dir['lib/**/*.rb']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_runtime_dependency 'typhoeus', '~> 1.0', '>= 1.0.1'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.8'
end
