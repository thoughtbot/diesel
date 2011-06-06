Feature: test a diesel engine using the bootstrapped application

  Background:
    Given a directory named "testengine"
    When I cd to "testengine"
    And I write to "Gemfile" with:
    """
    gem "rspec-rails", "~> 2.6.0"
    gem "rails"
    gem "sqlite3-ruby"
    """
    When I add this library as a dependency
    And I write to "spec/spec_helper.rb" with:
    """
    ENV["RAILS_ENV"] ||= 'test'
    require "diesel/testing"
    require 'rspec/rails'
    """
    When I write to "config/routes.rb" with:
    """
    Rails.application.routes.draw do
      match "/hello", :to => 'example#hello'
    end
    """
    When I reset Bundler environment variable
    And I run `bundle install --local`

  Scenario: use root_url
    When I write to "spec/controllers/example_controller_spec.rb" with:
    """
    require 'spec_helper'
    describe ExampleController do
      it "renders hello" do
        get :hello
        response.should redirect_to("/")
      end
    end
    """
    When I write to "app/controllers/example_controller.rb" with:
    """
    class ExampleController < ActionController::Base
      def hello
        redirect_to root_url
      end
    end
    """
    When I run `bundle exec rspec --format documentation spec`
    Then it should pass with:
    """
    0 failures
    """
    Then at least one example should have run

  Scenario: use ApplicationController
    When I write to "spec/controllers/example_controller_spec.rb" with:
    """
    require 'spec_helper'
    describe ExampleController do
      it "renders hello" do
        get :hello
        response.should be_success
      end
    end
    """
    When I write to "app/controllers/example_controller.rb" with:
    """
    class ExampleController < ApplicationController
      def hello
        render :nothing => true
      end
    end
    """
    When I run `bundle exec rspec --format documentation spec`
    Then it should pass with:
    """
    0 failures
    """
    Then at least one example should have run

  Scenario: use application layout
    When I write to "spec/controllers/example_controller_spec.rb" with:
    """
    require 'spec_helper'
    describe ExampleController do
      it "renders hello" do
        get :hello
        response.should be_success
      end
    end
    """
    When I write to "app/controllers/example_controller.rb" with:
    """
    class ExampleController < ActionController::Base
      def hello
        render :layout => 'application'
      end
    end
    """
    When I write to "app/views/example/hello.html.erb" with:
    """
    hello
    """
    When I run `bundle exec rspec --format documentation spec`
    Then it should pass with:
    """
    0 failures
    """
    Then at least one example should have run

