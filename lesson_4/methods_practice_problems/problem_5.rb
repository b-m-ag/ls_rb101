hash = { a: 'ant', b: 'bear' }
hash.shift

# => [:a, 'ant']
# Docs say that it "Removes the first element of self and returns it (shifting all other elements down by one)"
# In this case, it removes the first key-value pair and returns that as a two-item array