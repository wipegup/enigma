class Alphabet
    def initialize
      @alphabet = Alphabet.alphabet
    end

    def self.alphabet
      return ('a'..'z').to_a << " "
    end

    def shift_alphabet(num)
      return @alphabet.rotate(num)
    end
end
