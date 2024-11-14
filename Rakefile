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
