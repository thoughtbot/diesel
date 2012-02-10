# -*- encoding: utf-8 -*-
#
$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'diesel/version'

Gem::Specification.new do |s|
  s.name        = %q{diesel}
  s.version     = Diesel::VERSION.dup
  s.authors     = ["thoughtbot, inc.", "Joe Ferris"]
  s.email       = "support@thoughtbot.com"
  s.homepage    = "http://github.com/thoughtbot/diesel"
  s.summary     = %q{Diesel makes your engine go.}
  s.description = %q{Develop your Rails engines like you develop your Rails applications.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path  = ["lib"]

  s.add_dependency('railties')

  s.add_development_dependency('cucumber-rails', '~> 1.2.1 ')
  s.add_development_dependency('aruba')
  s.add_development_dependency('appraisal', '~> 0.4')
  s.add_development_dependency('rspec-rails', '~> 2.6.1')
  s.add_development_dependency('thin')
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('database_cleaner')
  s.add_development_dependency('turn')
  s.add_development_dependency('formtastic', '~> 1.2.3')

  s.platform = Gem::Platform::RUBY
  s.rubygems_version = %q{1.2.0}
end
