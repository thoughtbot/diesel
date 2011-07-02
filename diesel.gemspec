Gem::Specification.new do |s|
  s.name        = %q{diesel}
  s.version     = '0.1.5'
  s.summary     = %q{Diesel makes your engine go.}
  s.description = %q{Develop your Rails engines like you develop your Rails applications.}

  s.files        = Dir['[A-Z]*',
                       'config/**/*',
                       'app/**/*',
                       'lib/**/*.*',
                       'features/**/*',
                       'lib/generators/**/*',
                       'bin/**/*',
                       'spec/**/*.rb']
  s.require_path = 'lib'
  s.test_files   = Dir['features/**/*']

  s.executables  = ['diesel']

  s.authors = ["thoughtbot, inc.", "Joe Ferris"]
  s.email   = %q{support@thoughtbot.com}
  s.homepage = "http://github.com/thoughtbot/diesel"

  s.add_dependency('railties')

  s.add_development_dependency('cucumber-rails', '~> 0.5.1')
  s.add_development_dependency('appraisal')
  s.add_development_dependency('rspec-rails', '~> 2.6.1')
  s.add_development_dependency('thin')
  s.add_development_dependency('sqlite3-ruby')

  s.platform = Gem::Platform::RUBY
  s.rubygems_version = %q{1.2.0}
end
