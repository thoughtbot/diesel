Feature: test a diesel engine using rspec

  Scenario: create a diesel engine and test using rspec
    Given a directory named "testengine"
    When I cd to "testengine"
    And I write to "Gemfile" with:
    """
    gem "rspec-rails"
    gem "rails"
    gem "sqlite3-ruby"
    """
    When I add this library as a dependency
    And I write to "spec/controllers/example_controller_spec.rb" with:
    """
    ENV["RAILS_ENV"] ||= 'test'
    require "diesel/testing"
    require 'test/unit'
    require 'rspec/rails'

    describe ExampleController do
      it "renders hello" do
        get :hello
        response.should be_success
        response.should render_template("hello")
      end
    end
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
    hello!
    """
    When I write to "config/routes.rb" with:
    """
    Rails.application.routes.draw do
      match "/hello", :to => 'example#hello'
    end
    """
    When I run `bundle exec rspec --format documentation spec`
    Then it should pass with:
    """
    0 failures
    """
    Then at least one example should have run

