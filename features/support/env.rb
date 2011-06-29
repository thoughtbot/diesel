require 'aruba/cucumber'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

Before do
  @aruba_timeout_seconds = 20
end

Before('@slow') do
  @aruba_timeout_seconds = 180
end
