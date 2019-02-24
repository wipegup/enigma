require 'date'
module Shift
  def pad(int)
    return int.to_s.rjust(5, "0")
  end

  def random_number
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
    letters = (97..122).map{|num| num.chr}
    letters << " "
    return letters
  end

  def shift(num)
    return alphabet.rotate(num)
  end

  def split_to_keys(r_number)
    return (0..3).to_a.map{|idx| r_number[idx..idx+1]}
  end

  def create_offsets(date, r_number = nil)
    offset = square_date(date).to_s.chars[-4..-1]
    r_number = random_number if r_number == nil
    keys = split_to_keys( pad(r_number) )
    return keys.zip(offset).map{|key, offset| key.to_i + offset.to_i}

  end
end
