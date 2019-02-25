require './test/test_helper'
require './lib/alphabet'

class AlphabetTest < MiniTest::Test

  def setup
    @alphabet = Alphabet.new
  end

  def test_it_exists
    assert_instance_of Alphabet, @alphabet
  end

  def test_it_can_create_alphabet

    expected = ["a","b","c","d","e","f","g","h","i","j","k","l","m",
                "n","o","p","q","r","s","t","u","v","w","x","y","z"," "]
    assert_equal expected, Alphabet.alphabet
  end

  def test_it_can_shift_alphabet
    expected = ["c","d","e","f","g","h","i","j","k","l","m","n","o",
                "p","q","r","s","t","u","v","w","x","y","z"," ","a","b"]
    assert_equal expected, @alphabet.shift_alphabet(2)
  end
end
