require './test/test_helper'
require './lib/enigma'

class CaeserTest < MiniTest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_returns_correct_encoded_letter
    assert_equal "c", @enigma.encode("a", 2)
    assert_equal "d", @enigma.encode("b", 2)

    assert_equal "a", @enigma.encode("a", 0)
    assert_equal "b", @enigma.encode("b", 0)
  end

  def test_it_can_decode_characters
    assert_equal "a", @enigma.decode("c", 2)
    assert_equal "b", @enigma.decode("d", 2)
    assert_equal "y", @enigma.decode(" ",2)

    assert_equal "v", @enigma.decode("v", 0)
    assert_equal " ", @enigma.decode(" ", 0)
  end

  def test_it_can_find_shift_from_char
    assert_equal 2, @enigma.find_shift("a", "c")
    assert_equal 4, @enigma.find_shift("a", "e")
    assert_equal 1, @enigma.find_shift(" ", "a")
  end
end
