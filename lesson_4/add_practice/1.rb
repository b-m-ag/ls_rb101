flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

f_hash = {}

flintstones.each_with_index {|e, i| f_hash[e] = i}

p f_hash