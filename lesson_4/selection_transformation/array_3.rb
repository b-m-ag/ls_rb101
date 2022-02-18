def multiply(numbers, multiplicand)
  multiplied = []
  counter = 0

  loop do
    break if counter == numbers.size

    multiplied << numbers[counter] * multiplicand

    counter += 1
  end

  multiplied
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]
p my_numbers