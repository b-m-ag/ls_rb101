arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr.delete_if { |v| v.start_with?("s")}

p arr

arr_1 = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr_1.delete_if { |v| v.start_with?("s", "w")}

p arr_1