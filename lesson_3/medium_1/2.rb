# The result of the following statement will be an error:

puts "the value of 40 + 2 is " + (40 + 2)

# Why is this and what are two possible ways to fix this?

# Answer: This is because the numbers have not been converted to a string.
#
# 1) We can call .to_s on the equation (40 + 2)
puts "the value of 40 + 2 is " + (40 + 2).to_s
# 
# 2) Or, we can use string interpolation
num = (40 + 2) 
puts "the value of 40 + 2 is: #{num}"
