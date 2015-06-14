require "#{Dir.pwd}/lib/query_engine"

puts "Welcome to the Intergalactic Unit Converter"

loop do
  puts "- Enter 1: To convert intergalactic numerals to human numbers."
  puts "- Enter 2: To convert the value of materials from intergalactic numers to"\
       " human numbers."
  puts "- Enter 3: To exit"

  input = gets.chomp

  abort("bye bye now!!") if input == '3'

  while not ['1','2'].include?(input)
    puts "Whoops!! Computer says no!!!"
    puts "Please enter 1, 2 or 3."
    input = gets.chomp
    abort("bye bye now!!") if input == '3'
  end

  converter = QueryEngine.new(input)
  converter.run
end
