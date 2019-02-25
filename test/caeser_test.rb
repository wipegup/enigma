require './test/test_helper'
require './lib/caeser'

class CaeserTest < MiniTest::Test

  def test_it_exists
    assert_instance_of Caeser, Caeser.new
  end

  def test_it_returns_correct_encoded_letter
    assert_equal "c", Caeser.encode("a", 2)
    assert_equal "d", Caeser.encode("b", 2)

    assert_equal "a", Caeser.encode("a", 0)
    assert_equal "b", Caeser.encode("b", 0)
  end

  def test_it_can_decode_characters
    assert_equal "a", Caeser.decode("c", 2)
    assert_equal "b", Caeser.decode("d", 2)
    assert_equal "y", Caeser.decode(" ",2)

    assert_equal "v", Caeser.decode("v", 0)
    assert_equal " ", Caeser.decode(" ", 0)
  end

  def test_it_finds_index_of_letter
    alphabet = Alphabet.new

    assert_equal 0, alphabet.index_of("a")
    assert_equal 1, alphabet.index_of("b")
    assert_equal 25, alphabet.index_of("z")
    assert_equal 26, alphabet.index_of(" ")
  end

  def test_it_finds_letter_from_index
    alphabet = Alphabet.new
    assert_equal "a", alphabet.char_from_index(0)
    assert_equal "b", alphabet.char_from_index(1)
    assert_equal "z", alphabet.char_from_index(25)
    assert_equal " ", alphabet.char_from_index(26)
  end




end
