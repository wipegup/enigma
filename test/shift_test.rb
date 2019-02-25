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

  def test_it_squares_date_correctly
    date = "2019-02-21"
    expected = 44192027961
    actual = @enigma.square_date(date)

    assert_equal expected, actual
  end

  def test_it_creates_int_from_date
    date = "2019-02-21"
    expected = 210219

    assert_equal expected, @enigma.int_from_date(date)
  end

  def test_it_creates_random_number_in_correct_range
    (0..10000).each do |i|
      assert @enigma.generate_random_number >= 0
      assert @enigma.generate_random_number<=99999
    end
  end

  def test_it_creates_correct_shifts
    date = "2019-02-21"
    random_number = 2253
    offset = 7961
    expected = [9, 31, 31, 54]
    assert_equal expected, @enigma.determine_shifts(date, random_number)
  end

  def test_it_creates_offsets_from_date
    date = "2019-02-21"
    expected = [7,9,6,1]
    assert_equal expected, @enigma.offset_from_date(date)
  end

  def test_it_creates_keys_from_number
    random_number = 2253
    expected = [2,22,25,53]
    assert_equal expected, @enigma.keys_from_number(random_number)
  end

  def test_it_splits_random_number_correctly
    r_number = "02456"
    expected = ["02","24","45","56"]
    assert_equal expected, @enigma.split_to_keys(r_number)
  end
end
