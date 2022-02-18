{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# [nil, 'bear']
# map returns a new array whose elements are the return values of block
# the first iteration is nil because it doesn't meet requirements of block
# second does, so value is returned