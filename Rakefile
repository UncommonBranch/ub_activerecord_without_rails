# Initialize bundler
require 'bundler/setup'
Bundler.require :default, :test

require 'active_record'
include ActiveRecord::Tasks

namespace :db do
  task :load_config do
    DatabaseTasks.database_configuration = YAML.load_file('config/database.yml')
    DatabaseTasks.env = ENV['DB_ENV'] || 'development'
    ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  end

  desc 'Create database for given DB_ENV (default development)'
  task create: :load_config do
    # ActiveRecord depends on this environment variable
    ENV['RAILS_ENV'] = DatabaseTasks.env
    DatabaseTasks.create_current DatabaseTasks.env
  end

  desc 'Drop database for given DB_ENV (default development)'
  task drop: :load_config do
    # ActiveRecord depends on this environment variable
    ENV['RAILS_ENV'] = DatabaseTasks.env
    ActiveRecord::Tasks::DatabaseTasks.drop_current
  end

  desc 'Migrate database for given DB_ENV (default development)'
  task migrate: :load_config do
    config = DatabaseTasks.database_configuration
    env = DatabaseTasks.env
    ActiveRecord::Base.establish_connection config[env]

    DatabaseTasks.migrate
  end

  desc 'Drop, create, and migrate database for a given DB_ENV (default development)'
  task :reset => [:drop, :create, :migrate]
end
