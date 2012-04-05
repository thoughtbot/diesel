Feature: integration testing
  @slow
  Scenario: test integration of a diesel engine with a generated application
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
    When I write to "Gemfile" with:
    """
    gem "rails"
    gem "cucumber"
    gem "aruba"
    gem "rspec"
    """
    When I add this library as a dependency
    And I write to "db/migrate/create_examples.rb" with:
    """
    class CreateExamples < ActiveRecord::Migration
      def self.up
        create_table :examples do |table|
          table.string :title
        end
      end
    end
    """
    When I write to "app/models/example.rb" with:
    """
    class Example < ActiveRecord::Base
      attr_accessible :title
    end
    """
    When I write to "app/controllers/examples_controller.rb" with:
    """
    class ExamplesController < ActionController::Base
      def index
        Example.create!(:title => "Hello there")
        @examples = Example.all
        render
      end
    end
    """
    When I write to "app/views/examples/index.html.erb" with:
    """
    <% @examples.each do |example| -%>
      <p><%= example.title %></p>
    <% end -%>
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
      page.should have_content "Hello there"
    end

    When "I go to the examples page" do
      visit examples_path
    end
    """
    When I write to "lib/generators/testengine/install/install_generator.rb" with:
    """
    require 'diesel/generators/install_base'

    module Testengine
      module Generators
        class InstallGenerator < Diesel::Generators::InstallBase
        end
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
    When I write to "features/integration.feature" with:
    """
    @puts @announce
    Feature: integrate with application
      Scenario: generate a Rails app, run the generates, and run the tests
        When I successfully run `bundle exec rails new testapp --skip-test-unit --skip-bundle`
        And I cd to "testapp"
        And I comment out gem "turn" from my Gemfile
        And I add the "cucumber-rails" gem
        And I add the "capybara" gem
        And I add the "rspec-rails" gem
        And I add the "database_cleaner" gem
        And I add the "testengine" gem from this project
        And I add the "diesel" gem from the diesel project
        And I reset the Bundler environment variable
        And I run `bundle install --local`
        And I successfully run `bundle exec rails generate cucumber:install`
        And I successfully run `bundle exec rails generate testengine:install`
        And I successfully run `bundle exec rails generate testengine:features`
        And I successfully run `bundle exec rake db:migrate --trace`
        And I successfully run `bundle exec rake cucumber --trace`
        Then the output should contain "1 scenario (1 passed)"
        And the output should not contain "Could not find generator"
    """
    When I write to "features/support/env.rb" with:
    """
    require "diesel/testing/integration"
    Before do
      @aruba_timeout_seconds = 120
    end
    """
    When I write to "features/step_definitions/dependency_steps.rb" with:
    """
    # Make sure we use the local diesel
    When /^I add the "([^"]*)" gem from the diesel project$/ do |gem_name|
      append_to_file('Gemfile', %{\ngem "#{gem_name}", :path => "../../../../../.."\n})
    end

    When /^I reset the Bundler environment variable$/ do
      %w(RUBYOPT BUNDLE_PATH BUNDLE_BIN_PATH BUNDLE_GEMFILE).each do |key|
        ENV[key] = nil
      end
    end

    When /^I comment out gem "([^"]*)" from my Gemfile$/ do |gem_name|
      in_current_dir do
        content = File.read('Gemfile')
        File.open('Gemfile', 'w') do |f|
          f.write content.sub(/gem ['"]#{gem_name}/, '#\1')
        end
      end
    end
    """
    When I reset Bundler environment variable
    When I run `bundle install --local`
    And I successfully run `bundle exec cucumber features/integration.feature`
    Then it should pass with:
    """
    1 scenario (1 passed)
    """
    Then the output should not contain "undefined"

