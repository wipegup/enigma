module Caeser
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

    def find_shift(expected, actual)
      index_expected = index_of(expected)
      index_actual = index_of(actual)

      return index_actual - index_expected if index_actual >= index_expected
      return 27 - index_expected + index_actual
    end
end
