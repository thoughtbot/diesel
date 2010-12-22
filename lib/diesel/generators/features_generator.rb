require 'diesel/generators/base'

module Diesel
  module Generators
    class FeaturesGenerator < Diesel::Generators::Base
      def generate_features
        features.each do |feature|
          copy_file "features/engine/#{feature}", "features/#{engine_name}/#{feature}"
        end
      end

      def generate_step_definitions
        step_definitions.each do |step_definition|
          copy_file "features/step_definitions/engine/#{step_definition}",
                    "features/step_definitions/#{engine_name}/#{step_definition}"
        end
      end

      def self.inherited(generator)
        super
        generator.desc(<<-DESC)
          Copy cucumber feature files for the engine into your application.
        DESC
      end

      private

      def features
        files_within_root("features/engine", "*.feature")
      end

      def step_definitions
        files_within_root("features/step_definitions/engine", "*_steps.rb")
      end

      def files_within_root(prefix, glob)
        root = "#{self.class.source_root}/#{prefix}"
        Dir["#{root}/#{glob}"].sort.map do |full_path|
          full_path.sub(root, '.').gsub('/./', '/')
        end
      end
    end
  end
end


