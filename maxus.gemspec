# -*- encoding: utf-8 -*-
require File.expand_path('../lib/maxus/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["maxigrom"]
  gem.email         = ["max73ul@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "maxus"
  gem.require_paths = ["lib"]
  gem.version       = Maxus::VERSION

  gem.add_development_dependency "rspec"
  gem.add_runtime_dependency 'activesupport', '>= 3.0'
end
