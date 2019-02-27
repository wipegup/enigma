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
    shifts = find_all_shifts(cipher_text.reverse[0..3])
    rotate_amount = 4-((cipher_text.length) %4)
    shifts = shifts.reverse.rotate(rotate_amount)
    offsets = offset_from_date(date)

    uncorrected_keys = shifts.zip(offsets).map{ |shift, offset| shift - offset}

    key_start = uncorrected_keys[0].to_s.rjust(2, "0")
    key = key_start
    while key_start.length < 3
      uncorrected_keys[1..-1].each do |uk|
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

  def crack_cipher(message)
    reversed_cipher = message.reverse
    shifts = find_all_shifts(reversed_cipher[0..3])
    p "cracking #{shifts}"
    reversed_decoded = decrypt_ciphertext(reversed_cipher, shifts)
    return reversed_decoded.reverse
  end

  def find_all_shifts(last_four_reversed)
    shifts = []
    "dne ".chars.zip(last_four_reversed.chars).each do |actual, cipher|
      shifts << find_shift(actual, cipher)
    end
    return shifts
  end
end
