def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element # mutating original array
  buffer.shift if buffer.size > max_buffer_size
  buffer #returns original but mutated array
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element] # returning new array, input_array is the original
  buffer.shift if buffer.size > max_buffer_size
  buffer # returns new array, buffer
end

a = [1, 2, 3]
b = [1, 2, 3]

p rolling_buffer1(a, 3, 4)
p rolling_buffer2(b, 3, 4)