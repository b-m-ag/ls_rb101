greetings = { a: 'hi' }
informal_greeting = greetings[:a] # both now point to the same object
informal_greeting << ' there' # mutates the object that both :a and this v point to

puts informal_greeting  #  => "hi there"
puts greetings # => "{:a=> "hi there}"