module Shift
  def pad(int)
    return int.to_s.rjust(5, "0")
  end
end
