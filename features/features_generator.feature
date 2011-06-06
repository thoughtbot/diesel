Feature: reusable features generator

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
    When I write to "app/controllers/examples_controller.rb" with:
    """
    class ExamplesController < ActionController::Base
      def index
        render
      end
    end
    """
    When I write to "app/views/examples/index.html.erb" with:
    """
    Hello there
    """
    When I write to "config/routes.rb" with:
    """
    Rails.application.routes.draw do
      match "/examples", :to => 'examples#index'
    end
    """
    When I write to "lib/testengine.rb" with:
    """
    require 'rails'
    module Testengine
      class Engine < Rails::Engine
      end
    end
    """
    When I write to "lib/generators/testengine/features/features_generator.rb" with:
    """
    require 'diesel/generators/features_base'

    module Testengine
      module Generators
        class FeaturesGenerator < Diesel::Generators::FeaturesBase
        end
      end
    end
    """
    When I write to "features/engine/examples.feature" with:
    """
    Feature: view examples
      Scenario: go to the examples page
        When I go to the examples page
        Then I should receive a warm greeting
    """
    When I write to "features/step_definitions/engine/example_steps.rb" with:
    """
    Then %{I should receive a warm greeting} do
      Then %{I should see "Hello there"}
    end
    """
    When I cd to ".."
    And I successfully run "rails new testapp"
    And I cd to "testapp"
    And I append to "Gemfile" with:
    """
    gem "cucumber-rails"
    gem "capybara"
    gem "rspec"

    """
    When I add the "testengine" as a diesel engine
    And I successfully run "rails generate cucumber:install --trace"
    And I successfully run "rails generate testengine:features --trace"
    And I reset Bundler environment variable
    And I run `bundle install --local`

  Scenario: copy features into an app from a diesel engine
    When I run "bundle exec cucumber -r features features/testengine/examples.feature"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """

  Scenario: view generator descriptions from an app with a diesel engine
    When I successfully run "rails generate testengine:features -h"
    Then the output should contain:
    """
    Copy cucumber feature files for the engine into your application.
    """

