def mess_with_vars(one, two, three)
  one.gsub!("one","two") # replaces "one" with "two", destructive
  two.gsub!("two","three") # replaces "two" with "three", destructive
  three.gsub!("three","one") # replaces "three" with "one", destructive
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}" #two
puts "two is: #{two}" #three
puts "three is: #{three}" #one