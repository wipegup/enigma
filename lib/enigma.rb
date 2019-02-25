require_relative './shift.rb'
require_relative './alphabet.rb'

class Enigma
  include Shift

  def encrypt(message, key = nil, date = nil)
    date = todays_date if date == nil
    key = random_key if key == nil
    message = message.downcase
    
  end
end
