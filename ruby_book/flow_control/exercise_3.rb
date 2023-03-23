def number_check(num)
	case a
	when num >= 0 && num <= 50
		puts "this is 0-50"
	when num >= 51 && num <= 100
		puts "this is 51-100"
	when num > 100
		puts "100+"
	else
		puts "not in range, sorry"
	end
end

puts "please give a number 0-100"
number = gets.chomp

puts number_check(number)