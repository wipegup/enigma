require_relative './shift.rb'
require_relative './alphabet.rb'

class Enigma
  include Shift

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil

    alphabets = generate_alphabets(key, date)
    message = message.downcase
    return create_ciphertext(message, alphabets)
  end
end
