require './lib/enigma'
input, output, date = ARGV

enigma = Enigma.new
ciphertext = IO.read(input)
decrypted = enigma.crack(ciphertext, date)
IO.write(output, decrypted[:decryption])

puts "Created '#{output}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
