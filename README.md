Diesel [![Build Status](https://secure.travis-ci.org/thoughtbot/diesel.png)](http://travis-ci.org/thoughtbot/diesel)
======

Diesel gives your Rails engines power.

It makes it easier to have your Engine provide generators like:

* An "install" generator like "rails g clearance:install"
* A "features" generator like "rails g clearance:features"
* A "views" generator like "rails g clearance:views"

It makes it easier to test your Engine with Cucumber stories like:

    Scenario: generate a Rails app, run the generates, and run the tests
      When I successfully run `bundle exec rails new testapp`
      And I cd to "testapp"
      And I add the "cucumber-rails" gem
      And I add the "capybara" gem
      And I add the "rspec-rails" gem
      And I add the "database_cleaner" gem
      And I add the "diesel" gem
      And I add the "myengine" gem from this project
      And I reset the Bundler environment variable
      And I run `bundle install --local`
      And I successfully run `bundle exec rails generate cucumber:install`
      And I successfully run `bundle exec rails generate myengine:install`
      And I successfully run `bundle exec rails generate myengine:features`
      And I successfully run `bundle exec rake db:migrate --trace`
      And I successfully run `bundle exec rake --trace`
      Then the output should contain "1 scenario (1 passed)"
      And the output should not contain "Could not find generator"

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)

Diesel is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

Thank you to all [the contributors](https://github.com/thoughtbot/diesel/contributors)!

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

License
-------

Diesel is Copyright © 2010-2013 thoughtbot. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
