# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domino/version'

Gem::Specification.new do |spec|
  spec.name          = "domino"
  spec.version       = Domino::VERSION
  spec.authors       = ["kairi takemura"]
  spec.email         = ["thinglikeabar@gmail.com"]
  spec.summary       = %q{domino simulator}
  spec.description   = %q{domino simulator}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
