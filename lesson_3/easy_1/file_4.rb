numbers = [1, 2, 3, 4, 5]

numbers.delete_at(1) # this deletes at index 1, which contains 2
# => [1, 3, 4, 5]

numbers = [1, 2, 3, 4, 5]

numbers.delete(1) # this deletes the value 1, which is found once at index 0
# => [2, 3, 4, 5]