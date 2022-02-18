flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

first = flintstones.index { |e| e.start_with?("Be")}

puts first