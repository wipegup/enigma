require './test/test_helper'
require './lib/shift'

class ShiftTest <MiniTest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_pads_random_number
    raw = 78
    expected = "00078"

    assert_equal expected, @enigma.pad(raw)
  end

end
