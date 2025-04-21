source 'https://rubygems.org'

# Write actual dependencies for library to line-bot-api.gemspec
gemspec

group :development, :test do
  gem 'rbs', '~> 3.9.2'
  gem 'rubocop', '~> 1.75.0', require: false
  gem 'steep', '~> 1.10.0'
  gem 'yard', '~> 0.9.20'
end

group :test do
  gem 'addressable', '~> 2.3' # TODO: Delete it after cleaning up V1 code
  gem 'rake', '~> 13.0'
  gem 'rspec', '~> 3.13.0'
  gem 'webmock', '~> 3.25.0'
end
