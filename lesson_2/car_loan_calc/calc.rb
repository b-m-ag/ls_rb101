def prompt(message)
	Kernel.puts ("=> #{message}")
end

loop do
	prompt("Welcome to the mortgage calculator!")

	l_amount = ''
	loop do
		prompt "Please enter loan amount"
		l_amount = Kernel.gets().chomp()
		if l_amount.empty? || l_amount.to_f() < 0
			prompt("Please enter a positive number")
		else
			break
		end
	end

	l_yearly_length = ''
	l_monthly_length = ''
	loop do
		prompt("Please enter loan length (in years)")
		l_yearly_length = Kernel.gets().chomp()
		if l_yearly_length.empty? || l_yearly_length.to_f() < 0
			prompt("Please enter a positive number")
		else
			l_yearly_length = l_yearly_length.to_f()
			l_monthly_length = l_yearly_length * 12
			break
		end
	end

	interest_rate = ''
	loop do
		prompt("What is the interest rate? (5 for 5%, 2.5 for 2.5%, so on)")
		interest_rate = Kernel.gets().chomp()
		if interest_rate.empty? || interest_rate.to_f() < 0
			prompt("Please enter a positive number")
		else
			interest_rate = interest_rate.to_f() / 100
			break
		end
	end

	monthly_payment = l_amount.to_f() * (interest_rate.to_f() / (1 - (1 + interest_rate.to_f())**(-l_monthly_length.to_f())))
	prompt("Your monthly payment is $#{monthly_payment.round(2)}")
	
	prompt("Would you like to calculate again? (y is yes)")
	continue = Kernel.gets().chomp()
	if continue == 'y' || continue == 'Y'
		prompt("Let's go!")
	else
	prompt("Goodbye!")
		break
	end
end
