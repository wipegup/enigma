require 'date'
module Shift
  def pad(int)
    return int.to_s.rjust(5, "0")
  end

  def today
    return Date.today.strftime
  end
  
end
