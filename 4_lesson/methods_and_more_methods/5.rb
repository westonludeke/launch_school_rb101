# What does shift do in the following code? How can we find out?

hash = { a: 'ant', b: 'bear' }
p hash.shift


# Weston's answer: Shift removes a key-value pair from HSH and returns it as the two-item array [key, value]
# This means hash.shift removes a: 'ant' from the hash  and returns it as a two-item array. 
# Calling hash after returns {b: 'bear'}