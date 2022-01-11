require 'yaml'
MESSAGES = YAML.load_file('calc.yml')

def prompt(message)
	Kernel.puts ("=> #{message}")
end

def number?(num)
	integer?(num) || float?(num)
end

def integer?(num)
	num.to_i().to_s() == num
end

def float?(num)
	num.to_f().to_s() == num
end

def operation_to_message(op)
	output = case op
	when '1'
		'Adding'
	when '2'
		'Subtracting'
	when '3'
		'Multiplying'
	when '4'
		'Dividing'
	end
	output
end
prompt(MESSAGES['welcome'])

name = ''
loop do #name validation loop
	name = Kernel.gets().chomp()

	if name.empty?()
		prompt(MESSAGES['valid_name'])
	else
		break
	end
end

prompt("Hi #{name}")

loop do #main loop
	number1 = ''
	number2 = ''
	loop do #first number validation loop
		prompt("What's the first number?")
		number1 = Kernel.gets().chomp()

		if number?(number1)
			break
		else
			prompt("Hmm... that doesn't look like a valid number")
		end
	end
	loop do #second number validation loop
		prompt("What's the second number?")
		number2 = Kernel.gets().chomp()

		if number?(number2)
			break
		else
			prompt("Hmm... that doesn't look like a valid number")
		end
	end

	operator_prompt = <<-MSG
		What operation would you like to perform?
		1) add
		2) subtract
		3) multiply
		4) divide
	MSG
	
	prompt(operator_prompt)
	
	operator = ''
	loop do #operator validation loop
		operator = Kernel.gets().chomp()

		if %w(1 2 3 4).include?(operator)
			break
		else
			prompt("Must choose 1, 2, 3, or 4")
		end
	end

	prompt("#{operation_to_message(operator)} the two numbers...")

	result = case operator
	when '1'
		number1.to_i() + number2.to_i()
	when '2'
		result = number1.to_i() - number2.to_i()
	when '3'
		result = number1.to_i() * number2.to_i()
	when '4'
		result = number1.to_f() /  number2.to_f()
	end

	prompt(" The result is #{result}")

	prompt("Do you want to perform another calculation? (Y to calculate again)")
	answer = Kernel.gets().chomp()
	break unless answer.downcase().start_with?('y')
end

prompt "Thank you for using the calculator. Goodbye!"