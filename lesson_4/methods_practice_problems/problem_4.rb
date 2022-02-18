['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

# => {'a' => 'ant', 'b' => 'bear', 'c' => 'cat'}
# the each_with_object method created an empty hash
# in every iteration, the block creates an entry in the hash using value, the parameter, and its first letter
# it uses the index 0 which would be the first character in the string
# in this case, it is a and then assigns the original value passed in which is ant on the 1st iteration