require './test/test_helper'
require './lib/enigma'
class EnigmaTest < MiniTest::Test
  def setup
    @enigma = Enigma.new()
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_attributes
    @enigma.encrypt("m", "02573", "220219")
    assert_equal "02573", @enigma.key
    assert_equal "220219", @enigma.date
  end

  def test_it_creates_ciphertext
    shifts = [3, 27, 73, 20]
    message = "hello world"

    expected = 'keder ohulw'
    assert_equal expected, @enigma.create_ciphertext(message, shifts)
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

  def test_decrypt_follows_interaction_pattern
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    actual = @enigma.decrypt("keder ohulw", "02715", "040895")

    assert_equal expected, actual
  end

  def test_decrypt_ciphertext_works
    shifts =[3, 27, 73, 20]
    message = "keder ohulw"

    expected = "hello world"
    assert_equal expected, @enigma.decrypt_ciphertext(message, shifts)
  end

  def test_encrypt_can_be_used_without_specifying_date
    message = "hello"
    key = "02578"
    assert_instance_of Hash, @enigma.encrypt(message, key)
  end

  def test_decrypt_can_be_used_defaulting_to_todays_date
    message = "hello"
    key = "02578"
    assert_instance_of Hash, @enigma.decrypt(message, key)
  end

  def test_encrypt_can_generate_random_number_and_todays_date
    message = "Hello"
    assert_instance_of Hash, @enigma.encrypt(message)
  end


end
