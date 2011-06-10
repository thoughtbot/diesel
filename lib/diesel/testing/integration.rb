require 'aruba/cucumber'

When /^I add the "([^"]*)" gem$/ do |gem_name|
  append_to_file('Gemfile', %{\ngem "#{gem_name}"\n})
end

When /^I add the "([^"]*)" gem from this project$/ do |gem_name|
  append_to_file('Gemfile', %{\ngem "#{gem_name}", :path => "../../.."\n})
end

When /^I add the "([^"]*)" gem from git "([^"]*)"(?: on branch "([^"]*)")?$/ do |gem_name, git, branch|
  append_to_file('Gemfile', %{\ngem "#{gem_name}", :git => "#{git}"#{ %{, :branch => "#{branch}"} if branch}})
end
