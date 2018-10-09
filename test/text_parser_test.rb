# -*- encoding : utf-8 -*-
require 'test/unit'
require 'text_parser'

class TextParserTest < Test::Unit::TestCase
  def test_should_have_method_parse
    assert "string".respond_to?(:parse)
  end

  def test_should_parse
    text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium consectetur."
    assert_equal [{:word => "consectetur",  :hits => 2},
                  {:word => "dolor",        :hits => 1}],
                  text.parse(:dictionary => ["dolor", "consectetur"])
  end

  def test_should_parse_without_dictionary
    assert_equal [{:word => "test", :hits => 2}], "test test".parse
  end

  def test_should_remove_some_characters
    text = "Test? Test. Yes, test!"
    assert_equal [{:word => "test", :hits => 3}, {:word => "yes", :hits => 1}], text.parse
  end

  def test_should_return_an_empty_array
    assert_equal "test".parse(:dictionary => ['abc']), []
  end

  def test_should_order_by_word_asc
    text = ' beta omega gamma alpha gamma'
    result = [{:word => "alpha",  :hits => 1},
              {:word => "beta",   :hits => 1},
              {:word => "gamma",  :hits => 2},
              {:word => "omega",  :hits => 1}]
    assert_equal result, text.parse
    assert_equal result, text.parse(:order => :word)
    assert_equal result, text.parse(:order => :word, :order_direction => :asc)
  end

  def test_should_order_by_word_desc
    assert_equal [{:word => "zzz",  :hits => 1},
                  {:word => "aaa",  :hits => 1}], 'aaa zzz'.parse(:order => :word, :order_direction => :desc)
  end

  def test_should_order_ignoring_accents
    text = 'bílis ômega gato astuto árvore amora gato'
    result = [
      { :word => 'amora', :hits => 1 },
      { :word => 'árvore', :hits => 1 },
      { :word => 'astuto', :hits => 1 },
      { :word => 'bílis', :hits => 1 },
      { :word => 'gato', :hits => 2 },
      { :word => 'ômega', :hits => 1 }
    ]

    assert_equal result, text.parse(:order => :word, :order_style => :ignore_accents)
  end

  def test_should_order_ignoring_accents_desc
    text = 'bílis ômega gato árvore amora gato'
    result = [
      { :word => 'ômega', :hits => 1 },
      { :word => 'gato', :hits => 2 },
      { :word => 'bílis', :hits => 1 },
      { :word => 'árvore', :hits => 1 },
      { :word => 'amora', :hits => 1 }
    ]

    assert_equal result, text.parse(:order => :word, :order_style => :ignore_accents, :order_direction => :desc)
  end

  def test_should_not_ignore_accents_if_ordered_field_is_not_string
    text = 'bílis ômega gato astuto árvore amora gato'
    result = [
      { :word => 'gato', :hits => 2 },
      { :word => 'amora', :hits => 1 },
      { :word => 'árvore', :hits => 1 },
      { :word => 'astuto', :hits => 1 },
      { :word => 'bílis', :hits => 1 },
      { :word => 'ômega', :hits => 1 }
    ]
    parsed_text = text.parse(:order => :hits, :order_style => :ignore_accents, :order_direction => :desc)
    assert_equal 'gato', parsed_text.first[:word]
  end

  def test_should_order_by_hits_asc
    text = "gamma alpha gamma beta alpha gamma"
    result = [{:word => "beta",  :hits => 1},
              {:word => "alpha", :hits => 2},
              {:word => "gamma", :hits => 3}]
    assert_equal result, text.parse(:order => :hits)
    assert_equal result, text.parse(:order => :hits, :order_direction => :asc)
  end

  def test_should_order_by_hits_desc
    text = "gamma alpha gamma beta alpha gamma"
    assert_equal [{:word => "gamma",  :hits => 3},
                  {:word => "alpha",  :hits => 2},
                  {:word => "beta",   :hits => 1}],
                  text.parse(:order => :hits, :order_direction => :desc)
  end

  def test_should_ignore_negative_dictionary
    assert_equal [{:word => "good",  :hits => 1}], "This is good".parse(:negative_dictionary => ["is", "this"])
  end

  def test_should_works_with_special_characters
    assert_equal [], "*&%?!$#%$@\\'///[.](\")".parse
  end

  def test_should_works_hifen
    assert_equal [{:word => "self-service", :hits => 1}], "self-service".parse
  end

  def test_should_return_double_words
    assert_equal [{:word => "forrest gump", :hits => 1}],
                 "I like the movie Forrest Gump.".parse(:dictionary => ["Forrest Gump"])
  end

  def test_should_manage_null_args
    args = {:dictionary=>nil, :negative_dictionary=>nil, :order=>nil, :order_direction=>nil}
    assert_equal [{:word => "text", :hits => 1}], "text".parse(args)
  end

  def test_should_work_with_many_spaces
    text = "e se    eu     encher      de    espacos"
    assert_equal [{:word => "de",     :hits => 1},
                  {:word => "e",      :hits => 1},
                  {:word => "encher", :hits => 1},
                  {:word => "espacos",:hits => 1},
                  {:word => "eu",     :hits => 1},
                  {:word => "se",     :hits => 1}], text.parse
  end

  def test_should_keep_some_special_character
    assert_equal [{:word => "espaço", :hits => 1},
                  {:word => "sideral",:hits => 1}], "Espaço sideral".parse
    assert_equal [{:word => "açúcar", :hits => 1},
                  {:word => "pão",    :hits => 1}], "Pão açúcar".parse
    assert_equal [{:word => "ãéç",    :hits => 1}], "ãéç".parse
  end

  def test_minimum_length
    text = "a ab   abc "
    assert_equal [{:word => "a",    :hits => 1},
                  {:word => "ab",   :hits => 1},
                  {:word => "abc",  :hits => 1}], text.parse(:minimum_length => 1)
    assert_equal [{:word => "ab",   :hits => 1},
                  {:word => "abc",  :hits => 1}], text.parse(:minimum_length => 2)
    assert_equal [{:word => "abc",  :hits => 1}], text.parse(:minimum_length => 3)
    assert_equal [{:word => "abc",  :hits => 1}], text.parse(:minimum_length => 2, :negative_dictionary => ["ab"])
    assert_equal [],                              text.parse(:minimum_length => 3, :dictionary => ["a"])
  end
end
