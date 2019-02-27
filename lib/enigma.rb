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
    p "Cipher text shifts #{shifts}"
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

    p "fk #{shifts}"
    offsets = offset_from_date(date)

    raw_keys = shifts.zip(offsets).map{ |shift, offset| shift - offset}
    return valid_key_from_raw(raw_keys)
  end

  def valid_key_from_raw(raw_keys)
    key_start = raw_keys[0].to_s.rjust(2, "0")
    key = key_start
    while key_start.length < 3
      raw_keys[1..-1].each do |uk|
        start = key[-1].to_i
        x = ((start * 10 + 9)- uk)/27
        k = 27 * x + uk
        if ((k-27 != uk) && (k % 27 != uk)) || (k.to_s.rjust(2,"0")[0] != start.to_s)
          break
        end

        key += k.to_s.rjust(2,"0")[1]
      end
      break if key.length == 5
      key_start = (key_start.to_i + 27).to_s
      key = key_start
    end
    return key
  end

  def invalid_sequence?(key, to_add, raw_shift)
    return false if ((to_add - 27 != raw_shift) && (to_add % 27 != raw_shift))
    return false if to_add.to_s.rjust(2, "0")[0] != key[-1]
    return true
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
