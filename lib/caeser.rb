module Caeser

    def initialize
    end

    def alphabet
      return ('a'..'z').to_a << " "
    end

    def encode(char, shift)
      index = index_of(char)
      return alphabet.rotate(shift)[index]
    end

    def decode(char, shift)
      shifted_alphabet = alphabet.rotate(shift)
      index = shifted_alphabet.find_index(char)
      return alphabet[index]
    end

    def index_of(char)
      return 26 if char == " "
      return char.ord-97
    end
end
