require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

# test script in local, use rvm

task :prepare_test do
  sh 'ruby -v'
  # sh 'gem install bundler'
  # sh 'gem install rspec'
  sh 'gem install rack'
  sh 'gem install webmock'
end

task :test do
  sh 'rvm all do rake prepare_test'
  sh 'rvm all do rake'
end
