[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
	hsh.transform_values {|v| v + 1}
end