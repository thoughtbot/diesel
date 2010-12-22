When /^I add this library as a dependency$/ do
  append_to_file('Gemfile', %{\ngem "diesel", :path => "#{PROJECT_ROOT}"})
end

Then /^at least one example should have run$/ do
  Then %{the output should match /[1-9]0? examples?/}
end

