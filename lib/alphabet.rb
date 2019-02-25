class Alphabet
    attr_reader :alphabet
    def initialize
      @alphabet = Alphabet.alphabet
    end

    def self.alphabet
      return ('a'..'z').to_a << " "
    end

    def self.with_shift(shift)
      alphabet = Alphabet.new
      alphabet.shift_alphabet(2)
      return alphabet
    end

    def shift_alphabet(num)
      @alphabet =  @alphabet.rotate(num)
      return @alphabet
    end


end
