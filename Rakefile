require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# We don't want to push tags to source control when releasing the gem
Rake::Task["release"].clear

# Redefine `release` task to build and push gem to RubyGems without pushing to source control
## https://github.com/rubygems/bundler/blob/35be6d9a603084f719fec4f4028c18860def07f6/lib/bundler/gem_helper.rb#L53-L57
desc "Build and push gem to RubyGems without pushing to source control"
task "release", [:remote] => ["build", "release:guard_clean", "release:rubygem_push"] do
  puts "Built and pushed gem to RubyGems without pushing to source control."
end

## Development

desc "Run normal tests (exclude no_missing_require_* specs)"
task :test_normal, [:skip_tag] do |_, args|
  skip_tag = args[:skip_tag]

  rspec_opts = []
  rspec_opts << "--tag '~#{skip_tag}'" if skip_tag

  sh "bundle exec rspec --exclude-pattern 'spec/line/bot/line_bot_api_gem_spec.rb,spec/line/bot/line_bot_gem_spec.rb' #{rspec_opts.join(' ')}"
end

desc "Test line-bot-api gem spec"
task :test_line_bot_api do
  sh "bundle exec rspec --pattern 'spec/line/bot/line_bot_api_gem_spec.rb'"
end

desc "Test line/bot gem(?) spec"
task :test_line_bot do
  sh "bundle exec rspec --pattern 'spec/line/bot/line_bot_gem_spec.rb'"
end

desc "Run all tests in separate processes"
task :test do
  Rake::Task[:test_normal].invoke
  Rake::Task[:test_line_bot_api].invoke
  Rake::Task[:test_line_bot].invoke
end

desc "Validate comment for YARD"
task :validate_yard_comment do
  sh "bundle exec yard stats ./lib/line/bot/v2 --fail-on-warning"
end

desc "RBS type check"
task :rbs do
  sh "bundle exec rbs collection install"
  sh "bundle exec rbs -I sig validate"
end

desc "RBS type check (with steep)"
task :rbs_steep do
  sh "bundle exec steep check"
end

desc "RBS type check (with test)"
task :rbs_test do
  Dir['lib/line/bot/v2/**/*.rb'].sort.each do |file|
    require_relative file
  end

  line_v2_targets = ObjectSpace.each_object(Module)
                               .map(&:name)
                               .compact
                               .select do |mod_name|
    mod_name.start_with?('Line::Bot::V2::')
  end

  line_v2_targets = line_v2_targets.map { |name| "#{name}::*" }.uniq

  ENV['RUBYOPT']           = '-rbundler/setup -rrbs/test/setup'
  ENV['RBS_TEST_LOGLEVEL'] = 'error'
  ENV['RBS_TEST_RAISE']    = 'true'
  ENV['RBS_TEST_OPT']      = '-Isig'
  ENV['RBS_TEST_TARGET']   = line_v2_targets.join(',')

  Rake::Task[:test_normal].invoke('rbs_test:skip')
end

desc "Run rubocop"
task :rubocop do
  sh "bundle exec rubocop"
end

desc "Fix rubocop errors"
task :rubocop_fix do
  sh "bundle exec rubocop -A"
end

desc "Check buildable and its contents"
task :build_test do
  sh "bundle exec rake build"
  sh "tar -xvf pkg/line-bot-api-*.gem"

  puts "<<Show the contents of the gem>>"
  sh "tar -zxvf data.tar.gz"

  puts "<<clean up>>"
  sh "rm -rf pkg/"
  sh "rm -rf data.tar.gz"
  sh "rm -rf checksums.yaml.gz"
  sh "rm -rf metadata.gz"
end

desc "Run all tasks for development check and test"
task :ci do
  Rake::Task[:test].invoke
  Rake::Task[:rubocop].invoke
  Rake::Task[:validate_yard_comment].invoke
  Rake::Task[:rbs].invoke
  Rake::Task[:rbs_steep].invoke
  Rake::Task[:rbs_test].invoke
  Rake::Task[:build_test].invoke
end
