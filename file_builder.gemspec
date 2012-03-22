# -*- encoding: utf-8 -*-
require File.expand_path('../lib/file_builder/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mathieu Lajugie"]
  gem.email         = ["mathieul@gmail.com"]
  gem.summary       = %q{Describe and create multiple files using a simple DSL.}
  gem.homepage      = "http://github.com/mathieul/file_builder"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "file_builder"
  gem.require_paths = ["lib"]
  gem.version       = FileBuilder::VERSION

  gem.add_dependency 'blankslate', '>= 2.1.2.4'
end
