require './lib/enigma'
class EnigmaTest < MiniTest::Test
  def setup
    @enigma = Enigma.new()
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_encrypt_follows_interaction_pattern
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    actual = @enigma.encrypt("hello world", "02715", "040895")
    assert_equal expected, actual
  end


end
