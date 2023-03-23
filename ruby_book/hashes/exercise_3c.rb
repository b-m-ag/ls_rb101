def pair_printer(original = {})
	original.each_pair { |k, v| puts "#{k} is #{v}"}
end

pair_printer({age: 62, city: "New York City"})