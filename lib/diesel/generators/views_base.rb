require 'diesel/generators/base'

module Diesel
  module Generators
    class ViewsBase < Diesel::Generators::Base
      def generate_views
        views.each do |view|
          copy_file view
        end
      end

      def self.inherited(generator)
        super
        generator.desc(<<-DESC)
          Copy view files for the engine into your application.
        DESC
      end

      private

      def views
        files_within_root(".", "app/views/**/*.*")
      end
    end
  end
end


