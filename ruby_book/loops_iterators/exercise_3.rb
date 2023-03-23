def count_to_zero(num)
  if num <= 0
    puts num
  else
    puts num
    count_to_zero(num - 1)
  end
end
