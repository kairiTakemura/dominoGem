# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domino/version'

Gem::Specification.new do |spec|
  spec.name          = "domino"
  spec.version       = Domino::VERSION
  spec.authors       = ["Kairi Takemura"]
  spec.email         = ["a1346kt@aiit.ac.jp"]
  spec.summary       = %q{domino simulator}
  spec.description   = %q{domino simulator}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rmagick"

end
