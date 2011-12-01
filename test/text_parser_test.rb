require "test/unit"
require "string"
require "text_parser"

class TextParserTest < Test::Unit::TestCase
  def test_should_have_method_parse
    assert "some text".methods.select{|a| a=~/parse/}.count > 0
  end
  
  def test_should_parse
    text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium consectetur."
    assert_equal text.parse(["dolor", "consectetur"]), [{:word => "consectetur", :hits => 2}, {:word => "dolor", :hits => 1}]
  end
  
  def test_should_parse_without_dictionary
    text = "test test"
    assert_equal text.parse, [{:word => "test", :hits => 2}]
  end
  
  def test_should_remove_some_characters
    text = "Test? Test. Yes, test!"
    assert_equal text.parse, [{:word => "test", :hits => 3}, {:word => "yes", :hits => 1}]
  end
  
  def test_should_return_an_empty_array
    text = "test"
    assert_equal text.parse(['abc']), []
  end
  
  def test_should_order
    text = " beta omega gamma alpha gamma"
    assert_equal text.parse, [{:word => "alpha",  :hits => 1}, 
                              {:word => "beta",   :hits => 1},
                              {:word => "gamma",  :hits => 2},
                              {:word => "omega",  :hits => 1}]
  end
end