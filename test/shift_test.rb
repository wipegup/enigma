require './test/test_helper'
require './lib/shift'
require './lib/enigma'

class ShiftTest < MiniTest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_pads_random_number
    raw = 78
    expected = "00078"

    assert_equal expected, @enigma.pad(raw)
  end

  def test_it_returns_todays_date_in_correct_order
    todays_date = @enigma.today

    assert_equal "-", todays_date[4]
    assert_equal "-", todays_date[7]
    assert todays_date[0..3].to_i >= 2019
    assert todays_date[5..6].to_i <=12
    assert todays_date[8..9].to_i <= 31
  end

end
