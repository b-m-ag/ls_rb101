def factors(number)
  divisor = number
  factors = []
	
	while divisor > 0
  factors << number / divisor if number % divisor == 0
	# number % divisor == 0 calculates if divisor can go into number without remainder
  divisor -= 1
	end
	
	p factors #putting factors only returns the factors array without printing anything
end

factors(0)
factors(-3)
factors(80)