# -*- encoding: utf-8 -*-
require File.expand_path('../lib/one_to_one/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sohaib Bhatti"]
  gem.email         = ["sohaibbbhatti@gmail.com"]
  gem.description   = %q{Ruby Wrapper for 1to1cards SOAP API}
  gem.summary       = %q{Ruby Wrapper for 1to1cards SOAP API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "one_to_one"
  gem.require_paths = ["lib"]
  gem.version       = OneToOne::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'savon_spec'
  gem.add_dependency 'savon'
end
