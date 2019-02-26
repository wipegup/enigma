module Caeser

    def initialize
    end

    def alphabet
      return ('a'..'z').to_a << " "
    end

    def encode(char, shift)
      index = Caeser.index_of(char)
      return Caeser.alphabet.rotate(shift)[index]
    end

    def decode(char, shift)
      shifted_alphabet = Caeser.alphabet.rotate(shift)
      index = shifted_alphabet.find_index(char)
      return Caeser.alphabet[index]
    end

    def index_of(char)
      return 26 if char == " "
      return char.ord-97
    end
end
