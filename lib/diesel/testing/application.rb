require 'rails/all'

module Diesel
  module Testing
    APP_ROOT = File.expand_path('..', __FILE__).freeze

    class Application < Rails::Application
      config.encoding = "utf-8"
      config.action_mailer.default_url_options = { :host => 'localhost' }
      config.paths.config.database = "#{APP_ROOT}/database.yml"
      config.paths.log = "tmp/log"
      config.cache_classes = true
      config.whiny_nils = true
      config.consider_all_requests_local = true
      config.action_controller.perform_caching = false
      config.action_dispatch.show_exceptions = false
      config.action_controller.allow_forgery_protection = false
      config.action_mailer.delivery_method = :test
      config.active_support.deprecation = :stderr
      config.secret_token = "DIESEL" * 5 # so diesel
    end
  end
end

