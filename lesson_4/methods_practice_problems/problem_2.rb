['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

# => "returns the number of elements for which the block returns a truthy value"
# => ruby docs