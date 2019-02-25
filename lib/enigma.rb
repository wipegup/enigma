require_relative './shift.rb'
require_relative './caeser.rb'

class Enigma
  include Shift

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil

    shifts = generate_shifts(key, date)
    text = create_ciphertext(message.downcase, shifts)
    return {key:key, date:date, encryption: text }
  end
end
