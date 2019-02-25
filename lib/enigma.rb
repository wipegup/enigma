require_relative './shift.rb'
require_relative './caeser.rb'

class Enigma
  include Shift

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil

    shifts = generate_shifts( date,key)
    text = create_ciphertext(message.downcase, shifts)
    return {key:key, date:date, encryption: text }
  end

  def create_ciphertext(message, shifts)
    valid_chars = message.chars.find_all{ |char| Caeser.alphabet.include?(char)}
    encrypted_chars = valid_chars.map.with_index do |char, index|
       Caeser.encode(char, shifts[index%4])
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
      Caeser.decode(char, shifts[index%4])
    end
    return decrypted_chars.join("")
  end
end
