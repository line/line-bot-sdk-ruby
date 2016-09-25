require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :setup do
  sh 'ruby -v'
  sh 'gem install rspec rack webmock'
end
