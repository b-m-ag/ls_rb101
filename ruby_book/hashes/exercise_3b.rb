def value_printer(original = {})
	original.each_value { |v| puts v}
end

value_printer(age: 62, city: "New York City")