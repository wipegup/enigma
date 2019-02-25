class Alphabet
  
    def alphabet
      return ('a'..'z').to_a << " "
    end

    def shift_alphabet(num)
      return alphabet.rotate(num)
    end
end
