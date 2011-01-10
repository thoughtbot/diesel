Gem::Specification.new do |s|
  s.name        = %q{diesel}
  s.version     = '0.1.2'
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

  s.default_executable = 'diesel'
  s.executables        = ['diesel']

  s.has_rdoc = false

  s.authors = ["thoughtbot, inc.", "Joe Ferris"]
  s.email   = %q{support@thoughtbot.com}
  s.homepage = "http://github.com/thoughtbot/diesel"

  s.add_dependency('railties', '~> 3.0.3')

  s.platform = Gem::Platform::RUBY
  s.rubygems_version = %q{1.2.0}
end
