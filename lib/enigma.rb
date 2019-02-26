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

  def crack(message, date= nil)
    date = todays_date if date == nil
    reversed_cipher = message.chars.reverse
    shifts = find_all_shifts(reversed_cipher[0..3])
    decoded = reversed_cipher.map.with_index do |char, index|
      decode(char, shifts[index%4])
    end
    return decoded.reverse.join("")
  end

  def find_all_shifts(last_four_reversed)
    shifts = []
    "dne ".chars.zip(last_four_reversed).each do |actual, cipher|
      actual_index = alphabet.find_index(actual)
      cipher_index = alphabet.find_index(cipher)
      if cipher_index > actual_index
        shifts << cipher_index - actual_index
      else
        shifts << 27 - (actual_index - cipher_index)
      end

    end
    return shifts
  end


end
