require 'rails/generators'
require 'rails/generators/base'

module Diesel
  module Generators
    class Base < Rails::Generators::Base
      def self.source_root
        if engine
          @_diesel_source_root ||= File.expand_path(engine_root)
        end
      end

      def self.engine_root
        engine.root
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

