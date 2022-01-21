def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga" #essentially reassignment, no mutation
  an_array_param << "rutabaga" #this is concat, which mutates
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"#no mutation, will be the same
puts "My array looks like this now: #{my_array}"# =>["pumpkins", "rutabaga"]