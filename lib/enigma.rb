require_relative './shift.rb'
require_relative './alphabet.rb'

class Enigma
  include Shift

  def encrypt(message, key = nil, date = nil)
    date = int_from_date(today).to_s if date == nil
    key = pad(generate_random_number) if key == nil
    message = message.downcase
  end
end
