# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_parser/version'

Gem::Specification.new do |gem|
  gem.name          = "text_parser"
  gem.version       = TextParser::VERSION
  gem.authors       = ["Frederico de Paula"]
  gem.email         = ["fpaula@gmail.com"]
  gem.description   = %q{Includes a parse method on String object}
  gem.summary       = %q{Using method parse in the String object you can parse any text.}
  gem.homepage      = "https://github.com/fpaula/text_parser"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.require_paths = ["lib"]
end