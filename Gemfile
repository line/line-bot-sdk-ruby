source 'https://rubygems.org', cooldown: 7

# Pin bundler so Renovate keeps it up to date (BUNDLED WITH alone is not tracked by Renovate)
gem 'bundler', '~> 4.0.13'

# Write actual dependencies for library to line-bot-api.gemspec
gemspec

group :development, :test do
  gem 'irb', '~> 1.18.0'
  gem 'rack', '~> 3.1' # for yard server
  gem 'rackup', '~> 2.1' # for yard server
  gem 'rbs', '~> 4.0.0'
  gem 'redcarpet', '~> 3.6.0'
  gem 'rubocop', '~> 1.88.0', require: false
  gem 'steep', '~> 2.0.0'
  gem 'webrick', '~> 1.9.1'
  gem 'yard', '~> 0.9.20' # for yard server
end

group :test do
  gem 'rake', '~> 13.0'
  gem 'rspec', '~> 3.13.0'
  gem 'webmock', '~> 3.26.0'
end
