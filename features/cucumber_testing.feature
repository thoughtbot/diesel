@disable-bundler
Feature: test a diesel engine using cucumber

  Scenario: create a disel engine and test using cucumber
    Given a directory named "testengine"
    When I cd to "testengine"
    And I write to "Gemfile" with:
    """
    gem "cucumber-rails", "~> 0.3.2"
    gem "capybara", "~> 0.4.0"
    gem "rails", "~> 3.0.3"
    gem "rspec", "~> 1.3.0"
    gem "sqlite3-ruby"
    gem "formtastic", "~> 1.2.3"
    """
    When I add this library as a dependency
    When I write to "features/hello.feature" with:
    """
    Feature: say hello
      Scenario: go to the hello page
        When I go to /hello
        Then I should see "hello!"
    """
    When I write to "features/step_definitions/hello_steps.rb" with:
    """
    When /^I go to (\/.+)$/ do |path|
      visit path
    end

    Then /^I should see "([^"]*)"$/ do |text|
      page.should have_content(text)
    end
    """
    When I write to "features/support/env.rb" with:
    """
    ENV["RAILS_ENV"] ||= "test"
    require 'diesel/testing'
    require 'capybara/rails'
    require 'capybara/cucumber'
    require 'capybara/session'
    """
    When I write to "app/controllers/example_controller.rb" with:
    """
    class ExampleController < ActionController::Base
      def hello
        render
      end
    end
    """
    When I write to "app/views/example/hello.html.erb" with:
    """
    <%= semantic_form_for :nothing do |form| -%>
    hello!
    <% end -%>
    """
    When I write to "config/routes.rb" with:
    """
    Rails.application.routes.draw do
      match "/hello", :to => 'example#hello'
    end
    """
    When I run "bundle exec cucumber features/hello.feature"
    Then it should pass with:
    """
    1 scenario (1 passed)
    """

