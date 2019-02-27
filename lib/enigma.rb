require_relative './shift.rb'
require_relative './caeser.rb'

class Enigma
  include Shift, Caeser

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil
    shifts = generate_shifts(date, key)
    text = create_ciphertext(message.downcase, shifts)
    return {key:key, date:date, encryption: text }
  end

  def create_ciphertext(message, shifts)
    encrypted_chars = message.chars.map.with_index do |char, index|
       encode(char, shifts[index%4])
    end
    return encrypted_chars.join("")
  end

  def decrypt(message, key, date = nil)
    date  = todays_date if date == nil
    shifts = generate_shifts(date, key)
    text = decrypt_ciphertext(message, shifts)
    return {key:key, date:date, decryption: text }
  end


  def decrypt_ciphertext(message, shifts)
    decrypted_chars = message.chars.map.with_index do |char, index|
      decode(char, shifts[index%4])
    end
    return decrypted_chars.join("")
  end

  def crack(cipher_text, date = nil)
    date = todays_date if date == nil
    return {decryption: crack_cipher(cipher_text),
            date: date,
            key: find_key(cipher_text, date)}
  end

  def find_key(cipher_text, date)
    shifts = find_all_shifts(cipher_text)
    offsets = offset_from_date(date)

    raw_keys = shifts.zip(offsets).map{ |shift, offset| shift - offset}
    return valid_key_from_raw(raw_keys)
  end

  def valid_key_from_raw(raw_keys)
    key_start = raw_keys[0].to_s.rjust(2, "0")
    key = key_start
    while key_start.length < 3
      raw_keys[1..-1].each do |raw_shift|
        to_add = value_to_add(key, raw_shift)
        break if invalid_sequence?(key, to_add, raw_shift)
        key += to_add.to_s[-1]
      end
      return key if key.length == 5
      key_start = (key_start.to_i + 27).to_s
      key = key_start
    end
  end

  def value_to_add(key, raw_shift)
    multiplier = ((key[-1].to_i * 10 + 9) - raw_shift)/27
    27 * multiplier + raw_shift
  end

  def invalid_sequence?(key, to_add, raw_shift)
    return true if ((to_add - 27 != raw_shift) && (to_add % 27 != raw_shift))
    return true if to_add.to_s.rjust(2, "0")[0] != key[-1]
    return false
  end

  def crack_cipher(message)
    shifts = find_all_shifts(message)
    decrypt_ciphertext(message, shifts)
  end

  def find_all_shifts(message)
    last_four = message[-4..-1].chars
    shifts = " end".chars.zip(last_four).inject([]) do |shifts, (actual, cipher)|
      shifts << find_shift(actual, cipher)
    end
    return rotate_shifts(message, shifts)
  end

  def rotate_shifts(message, shifts)
    rotate_amount = 4-((message.length) %4)
    return shifts.rotate(rotate_amount)
  end
end
