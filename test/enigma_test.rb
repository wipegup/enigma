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
    message = "hello world!"

    expected = 'keder ohulw!'
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

  def test_crack_can_crack_code
    message = "hello end"
    encrypted = @enigma.encrypt(message, "02571", "250219")

    assert_equal "hello end", @enigma.crack_cipher(encrypted[:encryption])
  end

  def test_crack_with_todays_date
      message = "hello end"
      encrypted = @enigma.encrypt(message, "02571", "250219")

      expected = {decryption: "hello end",
                  date: "250219",
                  key: "02571"}
      # offset_from_date 7961
      # shifts 9, 34, 63, 72
      assert_equal expected, @enigma.crack(encrypted[:encryption], "250219")
  end

  def test_find_key
    cipher_text = "vjqtbeaweqihssi"
    date = "291018"
    expected = "08304"
    # "19348"
    assert_equal expected, @enigma.find_key(cipher_text, date)
  end

  def test_valid_key_from_raw_key
    raw_keys = [8,2,3,4]
    expected = "08304"

    assert_equal expected, @enigma.valid_key_from_raw(raw_keys)
  end

  def test_invalid_sequence
    assert_equal false, @enigma.invalid_sequence?("08", 83, 2)
    assert_equal true, @enigma.invalid_sequence?("08",84, 2)
    assert_equal true, @enigma.invalid_sequence?("08",29, 2)
    assert_equal false, @enigma.invalid_sequence?("02",25, -2)
  end

  def test_find_potential_value_to_add
    assert_equal 83, @enigma.value_to_add("08", 2)
  end


  def test_find_all_shifts_finds_correct_shifts
    message= "gzennlobc"
    # true_shift = [80, 39, 10, 42]
    expected_shift = [26, 12,10,15]

    assert_equal expected_shift, @enigma.find_all_shifts(message)
  end

  def test_rotate_shifts_to_correct_order
    cipher_text = "gzennuypc"
    shifts = [1,2,3,0]

    expected = [0,1,2,3]
    assert_equal expected, @enigma.rotate_shifts(cipher_text, shifts)
  end

  def test_it_creates_key_start
    assert_equal "02", @enigma.start_key(2, 0)
    assert_equal "29", @enigma.start_key(2,1)
  end

end
