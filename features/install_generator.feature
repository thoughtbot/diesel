Feature: reusable install generator

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
    When I write to "db/migrate/001_create_examples.rb" with:
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
    When I write to "lib/generators/testengine/install/install_generator.rb" with:
    """
    require 'diesel/generators/install_base'

    module Testengine
      module Generators
        class InstallGenerator < Diesel::Generators::InstallBase
          def copy_view
            copy_file "index.html.erb", "app/views/examples/index.html.erb"
          end
        end
      end
    end
    """
    When I write to "lib/generators/testengine/install/templates/index.html.erb" with:
    """
    <% @examples.each do |example| -%>
      <p><%= example.title %></p>
    <% end -%>
    """
    When I cd to ".."
    And I successfully run "rails new testapp"
    And I cd to "testapp"
    And I append to "Gemfile" with:
    """
    gem "cucumber-rails", "~> 0.3.2"
    gem "capybara", "~> 0.4.0"
    gem "rspec", "~> 1.3.0"

    """
    When I add the "testengine" as a diesel engine
    And I successfully run "rails generate cucumber:install --trace"
    And I successfully run "rails generate testengine:install --trace"
    And I successfully run "rake db:migrate db:schema:dump db:test:prepare --trace"
    And I reset Bundler environment variable
    And I run `bundle install --local`

  Scenario: test a generated app with a diesel engine
    When I write to "features/examples.feature" with:
    """
    Feature: view examples
      Scenario: go to the examples page
        When I go to the examples page
        Then I should see "Hello there"
    """
    When I run "bundle exec cucumber features/examples.feature"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """

  Scenario: view generator descriptions from an app with a diesel engine
    When I successfully run "rails generate testengine:install -h"
    Then the output should contain:
    """
    Generate configuration, migration, and other essential files.
    """

  Scenario: run the install generator twice
    When I successfully run "rails generate testengine:install --trace"
    Then the output should not contain "Another migration is already named"

