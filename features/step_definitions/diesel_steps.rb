When /^I add this library as a dependency$/ do
  append_to_file('Gemfile', %{\ngem "diesel", :path => "#{PROJECT_ROOT}"\n})
end

Then /^at least one example should have run$/ do
  steps %{Then the output should match /[1-9]0? examples?/}
end

When /^I add the "([^"]*)" as a diesel engine$/ do |engine_name|
  steps %{When I add this library as a dependency}
  append_to_file('Gemfile', <<-GEM)

    gem "#{engine_name}", :path => "#{PROJECT_ROOT}/tmp/aruba/#{engine_name}"

  GEM
end

When /^I comment out gem "([^"]*)" from my Gemfile$/ do |gem_name|
  in_current_dir do
    content = File.read('Gemfile')
    File.open('Gemfile', 'w') do |f|
      f.write content.sub(/gem ['"]#{gem_name}/, '#\1')
    end
  end
end
