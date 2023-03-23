family = { uncles: ["bob", "joe", "steve"], sisters: ["jane", "jill", "beth"],
brothers: ["frank", "rob", "david"],
aunts: ["mary", "saly", "susan"]
}
new_h = family.select {|k, v| k == :sisters || k == :brothers}

puts new_h