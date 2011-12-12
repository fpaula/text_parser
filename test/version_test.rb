# -*- encoding : utf-8 -*-
require "test/unit"
require "text_parser/version"

class TextParserTest < Test::Unit::TestCase
  def test_version
    assert_equal TextParser::Version.const_get("STRING"), "0.1.5" 
  end
end















