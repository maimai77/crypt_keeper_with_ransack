# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crypt_keeper_with_ransack/version'

Gem::Specification.new do |spec|
  spec.name          = "crypt_keeper_with_ransack"
  spec.version       = CryptKeeperWithRansack::VERSION
  spec.authors       = ["maimai77"]
  spec.email         = ["kohta0707@gmail.com"]
  spec.summary       = %q{add ransacker for crypted attributes}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "crypt_keeper", "~> 0.18.4"
  spec.add_dependency "ransack", "~> 1.6"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rails", "~> 4.1.9"
  spec.add_development_dependency "pg", "~> 0.18.1"
  spec.add_development_dependency "rspec-rails", "~> 3.1.0"
  spec.add_development_dependency "database_cleaner", "~> 1.4.0"
end
