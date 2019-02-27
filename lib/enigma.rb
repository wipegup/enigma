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
    shifts = find_all_shifts(cipher_text[-4..-1])
    shifts = rotate_shifts(cipher_text, shifts)
    p "fk #{shifts}"
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

  def rotate_shifts(message, shifts)
    rotate_amount = 4-((message.length) %4)
    return shifts.rotate(rotate_amount)
  end

  def crack_cipher(message)
    shifts = find_all_shifts(message[-4..-1])
    shifts = rotate_shifts(message, shifts)
    decrypt_ciphertext(message, shifts)
  end

  def find_all_shifts(last_four)
    " end".chars.zip(last_four.chars).inject([]) do |shifts, (actual, cipher)|
      shifts << find_shift(actual, cipher)
    end
  end
end
