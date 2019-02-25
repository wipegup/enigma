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

    def index_of(char)
      return 26 if char == " "
      return char.ord-97
    end

    def char_from_index(index)
      return Alphabet.alphabet[index]
    end

    def encode(char)
      index = index_of(char)
      return @alphabet[index]
    end

    def decode(char)
      index = @alphabet.find_index(char)
      return char_from_index(index)
    end


end
