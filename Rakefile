require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'rake/gempackagetask'
require 'cucumber/rake/task'

desc 'Default: run all tests'
task :default => [:cucumber]

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

eval("$specification = begin; #{IO.read('diesel.gemspec')}; end")
Rake::GemPackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end

