require 'diesel/generators/base'
require 'rails/generators/active_record/migration'

module Diesel
  module Generators
    class InstallBase < Diesel::Generators::Base

      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration

      def generate_migrations
        migrations.each do |migration|
          migration_template migration, migration.sub(%r{(db/migrate/)(?:\d+_)?}, '\1')
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
    end
  end
end

