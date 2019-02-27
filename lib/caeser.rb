module Caeser
    def alphabet
      return ('a'..'z').to_a << " "
    end

    def encode(char, shift)
      index = alphabet.find_index(char)
      return char if index == nil
      return alphabet.rotate(shift)[index]
    end

    def decode(char, shift)
      shifted_alphabet = alphabet.rotate(shift)
      index = shifted_alphabet.find_index(char)
      return char if index == nil
      return alphabet[index]
    end

    def find_shift(expected, actual)
      index_expected = alphabet.find_index(expected)
      index_actual = alphabet.find_index(actual)

      return index_actual - index_expected if index_actual >= index_expected
      return 27 - index_expected + index_actual
    end
end
