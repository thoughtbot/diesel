require 'diesel/generators/base'
require 'rails/generators/active_record/migration'

module Diesel
  module Generators
    class InstallBase < Diesel::Generators::Base

      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration

      def generate_migrations
        migrations.each do |source_file|
          name = migration_name(source_file)
          unless migration_exists?(name)
            migration_template source_file, "db/migrate/#{name}"
          end
        end
      end

      def self.inherited(generator)
        super
        generator.desc %{Generate configuration, migration, and other essential files.}
      end

      private

      def migrations
        files_within_root(".", "db/migrate/*.rb")
      end

      def migration_exists?(name)
        existing_migrations.include?(name)
      end

      def existing_migrations
        @existing_migrations ||= Dir.glob("db/migrate/*.rb").map do |file|
          migration_name(file)
        end
      end

      def migration_name(file)
        file.sub(%r{^.*(db/migrate/)(?:\d+_)?}, '')
      end
    end
  end
end

