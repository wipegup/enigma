require_relative './shift.rb'
require_relative './caeser.rb'

class Enigma
  include Shift, Caeser
  attr_reader :date, :key
  def initialize
    @date = nil
    @key = nil
  end

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil
    @date = date
    @key = key
    shifts = generate_shifts( date,key)
    text = create_ciphertext(message.downcase, shifts)
    return {key:key, date:date, encryption: text }
  end

  def create_ciphertext(message, shifts)
    p shifts
    valid_chars = message.chars.find_all{ |char| alphabet.include?(char)}
    encrypted_chars = valid_chars.map.with_index do |char, index|
       encode(char, shifts[index%4])
    end
    return encrypted_chars.join("")
  end

  def decrypt(message, key, date = nil)
    date  = todays_date if date == nil

    @date = date
    @key = key
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
    shifts = shifts.rotate(4-(cipher_text.length %4))
    
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
      actual_index = alphabet.find_index(actual)
      cipher_index = alphabet.find_index(cipher)
      shifts << find_shift_from_indicies(actual_index, cipher_index)
    end
    return shifts
  end

  def find_shift_from_indicies(actual, cipher)
      return cipher - actual if cipher > actual
      return 27 - (actual - cipher)
  end

end
