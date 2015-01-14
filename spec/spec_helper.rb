$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rails'
require 'active_record'
require 'crypt_keeper_with_ransack'
require 'fake_app'
require 'rspec/rails'
require 'database_cleaner'

RSpec.configure do |config|
  config.before :all do
    CreateAllTables.up unless ActiveRecord::Base.connection.table_exists? 'users'
  end

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around :each do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
