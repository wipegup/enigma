class Caeser

    def initialize
    end

    def self.alphabet
      return ('a'..'z').to_a << " "
    end

    def self.encode(char, shift)
      index = Caeser.index_of(char)
      return Caeser.alphabet.rotate(shift)[index]
    end

    def self.decode(char, shift)
      shifted_alphabet = Caeser.alphabet.rotate(shift)
      index = shifted_alphabet.find_index(char)
      return Caeser.alphabet[index]
    end

    def self.index_of(char)
      return 26 if char == " "
      return char.ord-97
    end
end
