hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |key, value|
	value.each do |string|
		string.each_char {|ch| puts ch if /[aieouAEIOU]/.match?(ch)}
	end
end