require "test/unit"
require "text_parser"

class TextParserTest < Test::Unit::TestCase

  def test_should_have_method_parse
    assert "some text".methods.select{|a| a == "parse"}.count > 0
  end
  
  def test_should_parse
    text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium consectetur."
    assert_equal text.parse(:dictionary => ["dolor", "consectetur"]), [{:word => "consectetur", :hits => 2}, {:word => "dolor", :hits => 1}]
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
    assert_equal text.parse(:dictionary => ['abc']), []
  end

  def test_should_order_by_word_asc
    text = " beta omega gamma alpha gamma"
    result = [{:word => "alpha",  :hits => 1}, 
              {:word => "beta",   :hits => 1},
              {:word => "gamma",  :hits => 2},
              {:word => "omega",  :hits => 1}]
    assert_equal text.parse, result
    assert_equal text.parse(:order => :word), result
    assert_equal text.parse(:order => :word, :order_direction => :asc), result
  end
  
  def test_should_order_by_word_desc
    assert_equal "aaa zzz".parse(:order => :word, :order_direction => :desc), [{:word => "zzz",  :hits => 1}, {:word => "aaa",  :hits => 1}]
  end
 
  def test_should_order_by_hits_asc
    text = "gamma alpha gamma beta alpha gamma"
    result = [{:word => "beta",  :hits => 1},
              {:word => "alpha", :hits => 2},
              {:word => "gamma", :hits => 3}]
    assert_equal text.parse(:order => :hits), result
    assert_equal text.parse(:order => :hits, :order_direction => :asc), result
  end
  
  def test_should_order_by_hits_desc
    text = "gamma alpha gamma beta alpha gamma"
    assert_equal text.parse(:order => :hits, :order_direction => :desc), [{:word => "gamma",  :hits => 3},
                                                                          {:word => "alpha",  :hits => 2},
                                                                          {:word => "beta",   :hits => 1}]
  end
  
  def test_should_ignore_negative_dictionary
    text = "This is good"
    assert_equal text.parse(:negative_dictionary => ["is", "this"]), [{:word => "good",  :hits => 1}]
  end
end