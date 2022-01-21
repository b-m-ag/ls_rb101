def return_new_values(a_string, an_array)
  a_string += "rutabaga"
  an_array += ['rutabaga']

	return a_string, an_array
end

string = "pumpkins"
array = ["pumpkins"]
string, array = return_new_values(string, array)

puts "My string looks like this now: #{string}"
puts "My array looks like this now: #{array}"