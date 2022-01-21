answer = 42

def mess_with_it(some_number)
  some_number += 8 # essentially reassignment, which isn't destructive
end

new_answer = mess_with_it(answer) # new_answer = 34 and answer = 42

p answer - 8 # 42 - 8 = 34