require 'diesel/generators/base'
require 'rails/generators/active_record/migration'

module Diesel
  module Generators
    class InstallGenerator < Diesel::Generators::Base
      #TODO: desc

      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration

      def generate_migrations
        migrations.each do |migration|
          migration_template migration
        end
      end

      private

      def migrations
        Dir["#{self.class.source_root}/db/migrate/*.rb"].sort.map do |full_migration_path|
          full_migration_path.sub(self.class.source_root, '.').gsub('/./', '/')
        end
      end
    end
  end
end

