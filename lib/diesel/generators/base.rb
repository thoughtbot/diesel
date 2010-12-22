require 'rails/generators'
require 'rails/generators/base'

module Diesel
  module Generators
    class Base < Rails::Generators::Base
      def self.source_root
        if engine
          @_diesel_source_root ||= engine_root
        end
      end

      def self.inherited(generator)
        super
        generator.source_paths << generator.template_root if generator.engine
      end

      def self.template_root
        File.join(engine_root,
                  "lib",
                  "generators",
                  engine_name.underscore,
                  generator_name,
                  'templates')
      end

      def self.engine_root
        File.expand_path(engine.root)
      end

      def self.engine
        @_diesel_engine ||= "#{engine_name}::Engine".constantize
      rescue NameError
        nil
      end

      def self.engine_name
        self.name.split('::').first
      end
    end
  end
end

