require 'bundler/gem_helper'
require 'cucumber/rake/task'
require 'appraisal'

Bundler::GemHelper.install_tasks

desc 'Default: run cucumber features'
task :default => [:all]

desc 'Test the plugin under all supported Rails versions.'
task :all => ["appraisal:cleanup", "appraisal:install"] do |t|
  exec('rake appraisal cucumber')
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end
