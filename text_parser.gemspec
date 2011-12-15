require "version"

Gem::Specification.new do |s|
  puts TextParser::Version.const_get("STRING")
  s.name        = "text_parser"
  s.version     = "0.1.6"
  s.author      = "Frederico de Paula"
  s.email       = "fpaula@gmail.com"
  s.summary     = "A easy way to parse a text."
  s.description = "Using method parse in the String object you can parse any text."
  s.files       = Dir["{lib/**/*.rb,README.rdoc,test/**/*.rb,Rakefile,*.gemspec,doc/**/*}"]
  s.homepage    = "http://textparser.heroku.com/"
end
