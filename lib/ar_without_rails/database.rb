require 'active_record'
require 'yaml'

module ArWithoutRails
  class Database
    def self.establish_database_connection
      filename = File.expand_path(File.join(File.dirname(__FILE__), '../../config/database.yml'))
      config = YAML.load_file(filename)[ENV['DB_ENV'] || 'development']
      ActiveRecord::Base.establish_connection config
    end
  end
end

ArWithoutRails::Database.establish_database_connection
