require "crypt_keeper_with_ransack/version"
require "crypt_keeper"
require "ransack"

module CryptKeeperWithRansack
  module CryptKeeper
    extend ActiveSupport::Concern

    included do
      alias_method_chain :crypt_keeper, :ransack
    end

    def crypt_keeper_with_ransack(*args)
      crypt_keeper_without_ransack(*args)

      if crypt_keeper_options.include?(:ransack)
        crypt_keeper_fields.each do |field|
          add_crypt_ransacker field, key: crypt_keeper_options[:key]
        end
      end
    end
  end

  module Ransack
    extend ActiveSupport::Concern

    module ClassMethods
      def add_crypt_ransacker(field, key: nil)
        ransacker field do |parent|
          Arel.sql "pgp_sym_decrypt(cast(#{field} AS bytea), '#{key}')"
        end
      end
    end
  end
end

CryptKeeper::Model::ClassMethods.include CryptKeeperWithRansack::CryptKeeper
ActiveRecord::Base.include CryptKeeperWithRansack::Ransack
