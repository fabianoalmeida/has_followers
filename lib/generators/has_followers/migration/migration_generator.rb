require 'generators/has_followers'

module HasFollowers
  module Generators
    class MigrationGenerator < Base
      desc "Generate has_followers migration"
      
      def create_migration_file
        migration_template "create_has_followers_tables.rb", File.join('db', 'migrate', "create_has_followers_tables.rb")
      end
    end
  end
end