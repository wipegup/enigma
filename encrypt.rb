require './lib/enigma'

input, output = ARGV

message = IO.read(input).gsub("\n","")
enigma = Enigma.new
encrypted = enigma.encrypt(message)
IO.write(output, encrypted[:encryption])
puts "Created '#{output}' with the key #{enigma.key} and date #{enigma.date}"
