require 'active_record'
require 'pg'

PG_SPEC = {
  :adapter  => 'postgresql',
  :database => 'crypt_keeper_with_ransack_test',
  :encoding => 'utf8'
}

# config
ActiveRecord::Base.establish_connection(PG_SPEC.merge(database: 'postgres', schema_search_path: 'public'))
ActiveRecord::Base.connection.drop_database PG_SPEC[:database] rescue nil
ActiveRecord::Base.connection.create_database(PG_SPEC[:database])
ActiveRecord::Base.establish_connection(PG_SPEC)

module CryptKeeperWithRansackTestApp
  class Application < Rails::Application
    config.secret_token = [*'A'..'z'].join
    config.session_store :cookie_store, :key => '_myapp_session'
    config.active_support.deprecation = :log
    config.eager_load = false
  end
end
CryptKeeperWithRansackTestApp::Application.initialize!

# models
class User < ActiveRecord::Base
  crypt_keeper :name, encryptor: :postgres_pgp, key: 'super_good_password', ransack: true
end

# migrations
class CreateAllTables < ActiveRecord::Migration
  def self.up
    enable_extension :pgcrypto
    create_table(:users) do |t|
      t.text :name
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
