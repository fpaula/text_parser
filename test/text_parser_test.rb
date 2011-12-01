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
  
  def test_should_parse_without_dictionary
    text = "test test"
    assert_equal text.parse, [{:word => "test", :hits => 2}]
  end
  
  def test_should_remove_some_characters
    text = "Test? Test. Yes, test!"
    assert_equal text.parse, [{:word => "test", :hits => 3}, {:word => "yes", :hits => 1}]
  end
  
  def test_should_not_parse
    text = "test"
    assert_equal text.parse(['abc']), []
  end
end