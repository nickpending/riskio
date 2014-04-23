# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riskio/version'

Gem::Specification.new do |spec|
  spec.name          = "riskio"
  spec.version       = Riskio::VERSION
  spec.authors       = ["Rudy Ruiz"]
  spec.email         = ["roodee@thummy.com"]
  spec.description   = %q{Riskio is a library for the RiskIO API and is designed is a simple
  wrapper that offers a mix between configuration, idiomatic consistency and less abstraction
  between the Riskio REST interface and this wrapper.}
  spec.summary       = %q{Riskio is a lightweight library for the RiskIO API.}
  spec.homepage      = "https://github.com/roodee/riskio"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 10.1"
  
  spec.add_runtime_dependency "rest_client", "~> 1.7"
  spec.add_runtime_dependency "json", "~> 1.8"
end
