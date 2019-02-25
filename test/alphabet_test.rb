require './test/test_helper'
require './lib/alphabet'

class AlphabetTest < MiniTest::Test

  def test_it_exists
    alphabet = Alphabet.new
    assert_instance_of Alphabet, alphabet
  end

  def test_it_can_create_alphabet

    expected = ["a","b","c","d","e","f","g","h","i","j","k","l","m",
                "n","o","p","q","r","s","t","u","v","w","x","y","z"," "]
    assert_equal expected, Alphabet.alphabet
  end

  def test_it_can_shift_alphabet
    alphabet = Alphabet.new
    expected = ["c","d","e","f","g","h","i","j","k","l","m","n","o",
                "p","q","r","s","t","u","v","w","x","y","z"," ","a","b"]
    assert_equal expected, alphabet.shift_alphabet(2)
  end

  def test_it_can_create_alphabet_with_shift
    expected = ["c","d","e","f","g","h","i","j","k","l","m","n","o",
                "p","q","r","s","t","u","v","w","x","y","z"," ","a","b"]
    alphabet = Alphabet.with_shift(2)
    assert_equal expected, alphabet.alphabet
  end

  def test_it_returns_correct_encoded_letter
    alphabet = Alphabet.with_shift(2)
    assert_equal "c", alphabet.encode("a")
    assert_equal "d", alphabet.encode("b")

    alphabet = Alphabet.new
    assert_equal "a", alphabet.encode("a")
    assert_equal "b", alphabet.encode("b")
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
