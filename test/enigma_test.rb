require './test/test_helper'
require './lib/enigma'
class EnigmaTest < MiniTest::Test
  def setup
    @enigma = Enigma.new()
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_creates_ciphertext
    shifts = [3, 27, 73, 20]
    message = "hello world"

    expected = 'keder ohulw'
    assert_equal expected, @enigma.create_ciphertext(message, shifts)
  end

  def test_encrypt_follows_interaction_pattern
    # skip
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    actual = @enigma.encrypt("hello world", "02715", "040895")
    assert_equal expected, actual
  end

  def test_decrypt_follows_interaction_pattern
    skip
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    actual = @enigma.decrypt("keder ohulw", "02715", "040895")

    assert_equal expected, actual
  end

  def test_encrypt_can_be_used_without_specifying_date
    skip
  end

  def test_decrypt_can_be_used_defaulting_to_todays_date
    skip
  end

  def test_encrypt_can_generate_random_number_and_todays_date
    skip
  end


end
