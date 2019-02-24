require 'date'
module Shift
  def pad(int)
    return int.to_s.rjust(5, "0")
  end

  def generate_random_number
    return rand(100000)
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

  def alphabet
    return ('a'..'z').to_a << " "
  end

  def shift_alphabet(num)
    return alphabet.rotate(num)
  end

  def split_to_keys(r_number)
    return (0..3).to_a.map{|idx| r_number[idx..idx+1]}
  end

  def create_offsets(date, random_number = nil)
    offset = square_date(date).to_s.chars[-4..-1]
    random_number = generate_random_number if random_number == nil
    keys = split_to_keys( pad(random_number) )
    return keys.zip(offset).map{|key, offset| key.to_i + offset.to_i}
  end
end
