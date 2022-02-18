[1, 2, 3].reject do |num|
  puts num
end

# => [1, 2, 3]
# reject returns a new array containing the items in self for which the given block is not true
# in this case, none of the items were nil