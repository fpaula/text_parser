# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'text_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "text_parser"
  spec.version       = TextParser::VERSION
  spec.authors       = ["Frederico de Paula"]
  spec.email         = ["fpaula@gmail.com"]
  spec.description   = %q{Includes a parse method on String object}
  spec.summary       = %q{Using method parse in the String object you can parse any text.}
  spec.homepage      = "https://github.com/fpaula/text_parser"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'test-unit', '~> 3.2'
end
