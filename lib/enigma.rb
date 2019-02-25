require_relative './shift.rb'
require_relative './caeser.rb'

class Enigma
  include Shift

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil

    shifts = generate_shifts(key, date)
    message = message.downcase
    return create_ciphertext(message, alphabets)
  end
end
