require "test/unit"
require "string"
require "text_parser"

class TextParserTest < Test::Unit::TestCase
  def test_method_parser
    assert "some text".methods.select{|a| a=~/parse/}.count > 0
  end
  
  def test_should_parse
    text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium consectetur."
    assert_equal text.parse(["dolor", "consectetur"]), [{:word => "dolor", :hits => 1}, {:word => "consectetur", :hits => 2}]
  end
end