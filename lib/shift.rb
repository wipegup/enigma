require 'date'
module Shift
  def pad(int)
    return int.to_s.rjust(5, "0")
  end

  def today
    return Date.today.strftime
  end

  def int_from_date(date)
    (date[-2..-1]+date[5..6]+date[2..3]).to_i
  end

  def square_date(date)
    return int_from_date(date) ** 2
  end
end
