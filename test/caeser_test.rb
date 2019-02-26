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

  def test_it_finds_index_of_letter
    assert_equal 0, @enigma.index_of("a")
    assert_equal 1, @enigma.index_of("b")
    assert_equal 25, @enigma.index_of("z")
    assert_equal 26, @enigma.index_of(" ")
  end
end
