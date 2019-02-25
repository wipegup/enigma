require 'date'
module Shift

  def determine_shifts(date = nil, random_number = nil)
    date = today if date == nil
    offset = offset_from_date(date)

    random_number = generate_random_number if random_number == nil
    keys = keys_from_number(random_number)

    return keys.zip(offset).map{|key, offset| key + offset}
  end

  def offset_from_date(date)
    date_squared_string = square_date(date).to_s
    last_four = date_squared_string.chars[-4..-1]
    return last_four.map{|char| char.to_i}
  end

  def keys_from_number(number)
    padded = pad(number)
    string_keys = split_to_keys(padded)
    return string_keys.map{|key| key.to_i}
  end

  def split_to_keys(r_number)
    return (0..3).to_a.map{|idx| r_number[idx..idx+1]}
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
    return int_from_date(today).to_s
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
