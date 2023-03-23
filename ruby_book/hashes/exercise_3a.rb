def key_printer(original = {})
	original.each_key { |key| puts key}
end

key_printer({age: 62, city: "New York City"})