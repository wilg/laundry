# -*- encoding: utf-8 -*-
require File.expand_path('../lib/laundry/version', __FILE__)

Gem::Specification.new do |gem|

  gem.authors       = ["Wil Gieseler"]
  gem.email         = ["supapuerco@gmail.com"]
  gem.description   = "A soapy interface to ACH Direct's PaymentsGateway.com service."
  gem.summary       = "A soapy interface to ACH Direct's PaymentsGateway.com service."
  gem.homepage      = "https://github.com/wilg/laundry"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "laundry"
  gem.require_paths = ["lib"]
  gem.version       = Laundry::VERSION

  gem.add_dependency 'savon'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'factory_girl'
  gem.add_development_dependency 'debugger'

end
