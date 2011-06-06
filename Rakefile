require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rake/gempackagetask'
require 'cucumber/rake/task'
require 'appraisal'

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

eval("$specification = begin; #{IO.read('diesel.gemspec')}; end")
Rake::GemPackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end

