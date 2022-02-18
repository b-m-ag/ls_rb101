[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# [1, nil, nil]
# puts is returned when num is bigger than 1
# puts is nil so the last two elements return nil