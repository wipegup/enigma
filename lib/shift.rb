require 'date'
module Shift

  def generate_shifts(date, random_number)
    offset = offset_from_date(date)
    keys = keys_from_number(random_number)
    return keys.zip(offset).map{|key, offset| key + offset}
  end

  def offset_from_date(date)
    date_squared_string = square_date(date).to_s
    last_four = date_squared_string.chars[-4..-1]
    return last_four.map{|char| char.to_i}
  end


  def keys_from_number(number)
    return (0..3).to_a.map{|idx| number[idx..idx+1].to_i}
  end

  def random_key
    return pad(generate_random_number)
  end

  def pad(int)
    return int.to_s.rjust(5, "0")
  end

  def generate_random_number
    return rand(100000)
  end

  def todays_date
    return string_from_date(today)
  end

  def today
    return Date.today.strftime
  end

  def string_from_date(date)
    (date[-2..-1]+date[5..6]+date[2..3])
  end

  def square_date(date)
    return date.to_i ** 2
  end
end
