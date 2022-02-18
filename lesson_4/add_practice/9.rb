def titleize(str)
	chars = str.split(' ')
	chars.map {|e| e.capitalize!}
	final = chars.join(' ')
	p final
end

words = "the flintstones rock"
titleize(words)