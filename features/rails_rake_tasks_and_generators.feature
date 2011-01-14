@disable-bundler
Feature: use Rails rake tasks when developing a diesel application

  Scenario: create a diesel engine and use Rails rake tasks
    Given a directory named "testengine"
    When I cd to "testengine"
    And I write to "Gemfile" with:
    """
    gem "rspec-rails", "~> 2.3.0"
    gem "rails", "~> 3.0.3"
    gem "sqlite3-ruby"
    """
    When I add this library as a dependency
    And I run "bundle install --local"
    And I write to "Rakefile" with:
    """
    require 'rubygems'
    require 'bundler/setup'
    require 'diesel/tasks'
    """
    When I successfully run "bundle exec diesel generate model post title:string"
    And I write to "spec/models/post_spec.rb" with:
    """
    ENV["RAILS_ENV"] ||= 'test'
    require "diesel/testing"
    require 'rspec/rails'

    describe Post do
      it "has a title" do
        Post.new.should respond_to(:title)
      end
    end
    """
    When I write to "app/models/post.rb" with:
    """
    class Post < ActiveRecord::Base
    end
    """
    When I successfully run "rake db:create db:migrate db:schema:dump db:test:prepare"
    And I run "bundle exec rspec --format documentation spec"
    Then it should pass with:
    """
    0 failures
    """
    Then at least one example should have run

