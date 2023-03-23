normal1 = { "a" => 100, "b" => 200}
normal2 = { "c" => 300, "d" => 400}
new_h = normal1.merge(normal2)

same1 = { "a" => 100, "b" => 200}
same2 = { "c" => 300, "d" => 400}

same1.merge!(same2)

p new_h
p same1