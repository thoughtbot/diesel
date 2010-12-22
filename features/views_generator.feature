@disable-bundler
Feature: reusable views generator

  Background:
    Given a directory named "testengine"
    When I cd to "testengine"
    And I write to "testengine.gemspec" with:
    """
    Gem::Specification.new do |s|
      s.name         = %q{testengine}
      s.version      = '1.0'
      s.files        = Dir['**/*']
      s.require_path = 'lib'
      s.add_dependency 'diesel'
    end
    """
    When I write to "app/views/examples/index.html.erb" with:
    """
    Hello there
    """
    When I write to "lib/testengine.rb" with:
    """
    require 'rails'
    module Testengine
      class Engine < Rails::Engine
      end
    end
    """
    When I write to "lib/generators/testengine/views/views_generator.rb" with:
    """
    require 'diesel/generators/views_base'

    module Testengine
      module Generators
        class ViewsGenerator < Diesel::Generators::ViewsBase
        end
      end
    end
    """
    When I cd to ".."
    And I successfully run "rails new testapp"
    And I cd to "testapp"
    And I add the "testengine" as a diesel engine
    And I run "bundle install --local"

  Scenario: copy views into an app from a diesel engine
    When I successfully run "rails generate testengine:views --trace"
    Then the file "app/views/examples/index.html.erb" should contain "Hello there"

  Scenario: view generator descriptions from an app with a diesel engine
    When I successfully run "rails generate testengine:views -h"
    Then the output should contain:
    """
    Copy view files for the engine into your application.
    """


